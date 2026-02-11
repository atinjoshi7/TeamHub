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

    init(vm: HomeViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            
            Group{
                if vm.employees.isEmpty && vm.isLoading{
                    List(0..<10, id:\.self){ _ in
                        EmployeeRowShimmerView()
                    }
                    .listStyle(.plain)
                }else{
                    List(vm.filteredEmployees) { employee in
                        NavigationLink {
                            EmployeeDetailsView(employee: employee)
                        } label: {
                            EmployeeRowView(employee: employee)
                        }
                    }
                }
            }
            .navigationTitle("Employees")
            .searchable(text: $vm.searchText,placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Search employees")
            .refreshable {
                await vm.load(forceRefresh: true)
            }
            .overlay {
//                if vm.isLoading {
//                    ProgressView("Loading...")
//                }
            }
            .task {
                await vm.load(forceRefresh: false)
            }
            .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    showFilterSheet = true
                                } label: {
                                    Image(systemName: "line.3.horizontal.decrease.circle")
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
//                Button("OK") { vm.errorMessage = nil }
            } message: {
                Text(vm.errorMessage ?? "")
            }
        }
    }
}
