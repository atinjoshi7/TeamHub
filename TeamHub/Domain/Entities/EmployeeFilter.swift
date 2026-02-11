//
//  EmployeeFilter.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation

enum EmployeeStatusFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case active = "Active"
    case inactive = "Inactive"

    var id: String { rawValue }
}

struct EmployeeFilter: Equatable {

    var selectedDepartments: Set<String> = []
    var selectedDesignations: Set<String> = []
    var status: EmployeeStatusFilter = .all

    var isEmpty: Bool {
        selectedDepartments.isEmpty &&
        selectedDesignations.isEmpty &&
        status == .all
    }
}


