////
////  HomeView.swift
////  TeamHub
////
////  Created by Jarvis on 11/02/26.
////
//
import SwiftUI
import UIKit

struct HomeView: View {
    
    @StateObject private var vm: HomeViewModel
    @State private var showFilterSheet = false
    @EnvironmentObject private var networkStatus : NetworkMonitor
    @State private var showConnectivityBanner = false
    @State private var bannerStyle: Style = .online
    @State private var bannerText: String = ""
    @FocusState private var isSearchFocused:Bool
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var path = NavigationPath()
    
    init(vm: HomeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack(path: $path){
            
            if networkStatus.isConnected == false && vm.employees.isEmpty {
                NoInternetView()
            }else{
                VStack(spacing: 0){
                    CustomSearchBar(text: $vm.searchText, placeHolder: "Search employees", isFocused: $isSearchFocused)
                        .padding(.bottom,10)
                    
                    ZStack{
                        // If no user found after search/filter.
                        if vm.filteredEmployees.isEmpty  {
                            NoUserFound()
                        }
                       
                        List {
                            
                            if vm.employees.isEmpty && vm.isLoading {
                                ForEach(0..<10, id: \.self) { _ in
                                    EmployeeRowShimmerView()
                                }
                            } else {
                                ForEach(vm.filteredEmployees) { employee in
                                    EmployeeRowView(employee: employee)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            path.append(employee)
                                        }
                                }
                                
                            }
                            
                        }
                        .scrollDismissesKeyboard(.immediately)
                        .refreshable {
                            print("refreshed data")
                            await vm.load(forceRefresh: true)
                        }
                    }
                }
                
                .listStyle(.plain)
                .navigationTitle("Employees")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    HomeToolBarView(
                        showFilterSheet: $showFilterSheet,
                        filter: vm.filter,
                    ){
                        isSearchFocused = false
                    }
                }
                
                .sheet(isPresented: $showFilterSheet) {
                    EmployeeFilterSheetView(
                        departments: vm.availableDepartments,
                        designations: vm.availableDesignations,
                        filter: $vm.filter
                    )
                }
                .alert("Error", isPresented: .constant(vm.errorMessage != nil)) {
                    Button("OK") {
                        vm.clearError()
                        
                    }
                } message: {
                    Text(vm.errorMessage ?? "")
                }
                .navigationDestination(for: Employee.self){
                    employee in
                    EmployeeDetailsView(employee: employee)
                }
            }
            
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                isSearchFocused = false
            }
        )
        .overlay(alignment: .top){
            if showConnectivityBanner{
                ConnectivityBanner(style: bannerStyle, text: bannerText)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .animation(.spring(), value: showConnectivityBanner)
            }
        }
        .onChange(of: networkStatus.isConnected){
            status in
            if status == false {
                bannerStyle = .offline
                bannerText = "Offline mode"
                showConnectivityBanner = true
            }
            else {
                bannerStyle = .online
                bannerText = "Back Online"
                showConnectivityBanner = true
                Task{
                    print("Internet is on")
                    await vm.load(forceRefresh: false)
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    showConnectivityBanner = false
                }
                
            }
        }
        .task(id: "Load only once"){
            print("Fix fetched")
            await vm.load(forceRefresh: false)
        }
    }
    
}
