//
//  HomeView.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var vm: HomeViewModel
    @State private var showFilterSheet = false
    @EnvironmentObject private var networkStatus : NetworkMonitor
    @State private var showConnectivityBanner = false
    @State private var bannerStyle: ConnectivityBanner.Style = .online
    @State private var bannerText: String = ""
    @FocusState private var isSearchFocused:Bool
    
    init(vm: HomeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }

    var body: some View {
        NavigationStack {
            
            if networkStatus.isConnected == false && vm.employees.isEmpty {
                NoInternetView()
            }else{
                VStack(spacing: 0){
                    
                    
                    
                    CustomSearchBar(text: $vm.searchText, placeHolder: "Search employees", isFocused: $isSearchFocused)
                    ZStack{
                        
                        
                        if vm.filteredEmployees.isEmpty && !vm.searchText.isEmpty{
                            NoUserFound()
                                .frame(width: .infinity, height: .infinity)
                        }
                        List {
                            
                            if vm.employees.isEmpty && vm.isLoading {
                                ForEach(0..<10, id: \.self) { _ in
                                    EmployeeRowShimmerView()
                                }
                            } else {
                                ForEach(vm.filteredEmployees) { employee in
                                    NavigationLink {
                                        EmployeeDetailsView(employee: employee)
                                    } label: {
                                        EmployeeRowView(employee: employee)
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Employees")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showFilterSheet = true
                            isSearchFocused = false
                        } label: {
                            Image(systemName: vm.filter.isApplied
                                  ? "slider.horizontal.3"
                                  : "slider.horizontal.3"
                            )

                            Text("\(vm.filter.totalCount)")
                        }
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
            }
        }
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
                bannerText = "No Internet Connection"
                showConnectivityBanner = true
            }
            else {
                bannerStyle = .online
                bannerText = "Back Online"
                showConnectivityBanner = true
                Task{
                    print("Internet is on")
                   try? await Task.sleep(nanoseconds: 2_000_000_000)
                    showConnectivityBanner = false
                }
                
            }
        }
        .refreshable {
            await vm.load(forceRefresh: true)
        }
        .task() {
            print("Fix fetched")
            await vm.load(forceRefresh: false)
        }
//        .onAppear{
//            isSearchFocused = false
//        }
    }
        
}


