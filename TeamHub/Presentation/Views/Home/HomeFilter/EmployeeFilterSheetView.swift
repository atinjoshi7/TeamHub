//
//  EmployeeFilterSheetView.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import SwiftUI

struct EmployeeFilterSheetView: View {

    let departments: [String]
    let designations: [String]
    @State private var statusColor: Color = .white
    @Binding var filter: EmployeeFilter
    @Environment(\.dismiss) private var dismiss
    @State private var tempFilter: EmployeeFilter
    
    init(departments: [String], designations: [String],filter: Binding<EmployeeFilter>){
        self.departments = departments
        self.designations = designations
        _filter = filter
        _tempFilter = State(initialValue: filter.wrappedValue)
    }
    var body: some View {
        NavigationStack {
            List {

                // Status
                Section("Status") {
                    Picker("Status", selection: $tempFilter.status) {
                        ForEach(EmployeeStatusFilter.allCases) { item in
                            Text(item.rawValue).tag(item)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // Department multi-select
                Section("Department") {
                    if departments.isEmpty {
                        Text("No departments available")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(departments, id: \.self) { dept in
                            MultipleSelectRow(
                                title: dept,
                                isSelected: tempFilter.selectedDepartments.contains(dept)
                            ) {
                                toggleDepartment(dept)
                            }
                        }
                    }
                }

                // Designation multi-select
                Section("Designation") {
                    if designations.isEmpty {
                        Text("No designations available")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(designations, id: \.self) { desig in
                            MultipleSelectRow(
                                title: desig,
                                isSelected: tempFilter.selectedDesignations.contains(desig)
                            ) {
                                toggleDesignation(desig)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Filters")
            .toolbar {

                ToolbarItem(placement: .topBarLeading)  {
                    Button("Reset") {
                        tempFilter = EmployeeFilter()
//                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                       filter = tempFilter
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
            .tint(.primary)
        }
    }

    private func toggleDepartment(_ dept: String) {
        if tempFilter.selectedDepartments.contains(dept) {
            tempFilter.selectedDepartments.remove(dept)
        } else {
            tempFilter.selectedDepartments.insert(dept)
        }
    }

    private func toggleDesignation(_ desig: String) {
        if tempFilter.selectedDesignations.contains(desig) {
            tempFilter.selectedDesignations.remove(desig)
        } else {
            tempFilter.selectedDesignations.insert(desig)
        }
    }
}
