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
    @FocusState private var isSearchFocused:Bool
    @EnvironmentObject private var networkStatus : NetworkMonitor
    @State private var showConnectivityBanner = false
    @State private var bannerStyle: Style = .online
    @State private var bannerText: String = ""
    
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
                    // search bar
                    CustomSearchBar(text: $vm.searchText, placeHolder: "Search employees", isFocused: $isSearchFocused)
                        .padding(.bottom,10)
                    // NEW EMPLOYEE BANNER
                      if vm.newEmployeesCount > 0 {

                          HStack {

                              Text("\(vm.newEmployeesCount) new employee added")
                                  .font(.subheadline)
                                  .fontWeight(.medium)

                              Spacer()

                              Button {
                                  Task {
                                      await vm.load(forceRefresh: true)
                                  }
                              } label: {
                                  Image(systemName: "arrow.clockwise.circle.fill")
                                      .font(.title2)
                              }

                          }
                          .padding(.horizontal)
                          .padding(.vertical, 10)
                          .background(Color.green.opacity(0.15))
                      }
                    
                    ZStack{
                        // If no user found after search/filter.
                        if vm.filteredEmployees.isEmpty  {
                            NoUserFound()
                        }
                       
                            List {
                                // Shimmer Effect when user data is getting fetched.
                                if vm.employees.isEmpty && vm.isLoading {
                                    ForEach(0..<10, id: \.self) { _ in
                                        EmployeeRowShimmerView()
                                    }
                                }
                                /*Employee list after filtering the employee list*/
                                else {
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
                            .listStyle(.plain)
                        
                    }
                }
                .navigationTitle("Employees")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    /* HomeToolBarView is handling the filter and dark/light mode */
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
        // Checks the internet connection.
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
        .task {
            while true {
                try? await Task.sleep(nanoseconds: 5_00_000_000)
                await vm.load(forceRefresh: false)
            }
        }
    }
    
}
