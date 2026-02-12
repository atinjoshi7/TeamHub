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

    @Binding var filter: EmployeeFilter
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {

                // Status
                Section("Status") {
                    Picker("Status", selection: $filter.status) {
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
                                isSelected: filter.selectedDepartments.contains(dept)
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
                                isSelected: filter.selectedDesignations.contains(desig)
                            ) {
                                toggleDesignation(desig)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Filters")
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset") {
                        filter = EmployeeFilter()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }

    private func toggleDepartment(_ dept: String) {
        if filter.selectedDepartments.contains(dept) {
            filter.selectedDepartments.remove(dept)
        } else {
            filter.selectedDepartments.insert(dept)
        }
    }

    private func toggleDesignation(_ desig: String) {
        if filter.selectedDesignations.contains(desig) {
            filter.selectedDesignations.remove(desig)
        } else {
            filter.selectedDesignations.insert(desig)
        }
    }
}
