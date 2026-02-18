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
    var isApplied: Bool{
        if status != .all {return true}
        if selectedDepartments.isEmpty == false {return true}
        if selectedDesignations.isEmpty == false {return true}
        return false
    }
    var totalCount: Int{
        var count: Int = 0
        if status != .all{
            count += 1
        }
        if selectedDepartments.isEmpty == false{
            count += 1
        }
        if selectedDesignations.isEmpty == false{
            count += 1
        }
        return count
    }
}



