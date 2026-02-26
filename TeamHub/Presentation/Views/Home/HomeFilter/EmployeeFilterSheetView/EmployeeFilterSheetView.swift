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
    @State private var tempFilter: EmployeeFilter
    @Environment(\.colorScheme) private var colorScheme
    
    private var showDotOnAll: Bool {
        tempFilter.selectedDepartments.isEmpty == false ||
        tempFilter.selectedDesignations.isEmpty == false
    }
    
    private var showDotOnStatus: Bool {
        tempFilter.status != .all
    }
    
    // Tabs
    private enum FilterTab: String, CaseIterable, Identifiable {
        case all = "All"
        case status = "Status"
        
        var id: String { rawValue }
    }
    
    @State private var selectedTab: FilterTab = .all
    
    private var selectedBackgroundColor: Color {
        if colorScheme == .dark {
            return Color.white.opacity(0.15)
        } else {
            return Color.accentColor.opacity(0.15)
        }
    }

    private var selectedTextColor: Color {
        if colorScheme == .dark {
            return .white
        } else {
            return .primary
        }
    }

    private var unselectedBackgroundColor: Color {
        Color.clear
    }
    
    init(departments: [String], designations: [String],filter: Binding<EmployeeFilter>){
        self.departments = departments
        self.designations = designations
        _filter = filter
        _tempFilter = State(initialValue: filter.wrappedValue)
    }
    var body: some View {
        
        NavigationStack {
            List {
                // All/Status
                Section {
                    HStack{
                        tabButton(
                            title: "All",
                            tab: .all,
                            showDot: showDotOnAll
                        )
                        tabButton(
                            title: "Status",
                            tab: .status,
                            showDot: showDotOnStatus
                        )

                    }

                }
                if selectedTab == .all {
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
                else{
                    // Status only
                    Section("Status") {
                        
                        statusRow(.active)
                        statusRow(.inactive)
                        
                    }
                }
            }
            
            .navigationTitle("Filters")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading)  {
                    Button("Clear") {
                        tempFilter = EmployeeFilter()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Apply") {
                        filter = tempFilter
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
            .tint(.primary)
        }
    }
    private func tabButton(title: String, tab: FilterTab, showDot: Bool) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = tab
            }
        } label: {
            HStack {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(selectedTab == tab ? selectedTextColor : .primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(selectedTab == tab ? selectedBackgroundColor : unselectedBackgroundColor)
                            .padding(2)
                    )
                    .overlay(alignment: .topTrailing) {
                        if showDot {
                            Circle()
                                .fill(.blue)
                                .frame(width: 7, height: 7)
                                .padding(.top, 6)
                                .padding(.trailing, 12)
                        }
                    }
                    .contentShape(Rectangle())
            }
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .stroke(Color.primary.opacity(0.15), lineWidth: 1)
        )
    }
    private func statusRow(_ item: EmployeeStatusFilter) -> some View {
        Button {
            
            // tap again = unselect (back to all)
            if tempFilter.status == item {
                tempFilter.status = .all
            } else {
                tempFilter.status = item
            }
            
        } label: {
            HStack {
                Text(item.rawValue)
                Spacer()
                
                if tempFilter.status == item {
                    Image(systemName: "checkmark")
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
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
