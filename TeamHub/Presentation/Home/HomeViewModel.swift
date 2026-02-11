//
//  HomeViewModel.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published private(set) var employees: [Employee] = []
    @Published var searchText: String = ""
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    @Published var filter = EmployeeFilter()
    
    private let getEmployeesUseCase: GetEmployeesUseCase
    
    init(getEmployeesUseCase: GetEmployeesUseCase) {
        self.getEmployeesUseCase = getEmployeesUseCase
    }
    
    var availableDepartments: [String] {
        Array(Set(employees.map { $0.department}))
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false }
            .sorted()
    }

    var availableDesignations: [String] {
        Array(Set(employees.map { $0.designation}))
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false }
            .sorted()
    }

    var filteredEmployees: [Employee] {

        var result = employees

        // 1) Apply status filter
        if filter.status == .active {
            result = result.filter { $0.isActive == true }
        } else if filter.status == .inactive {
            result = result.filter { $0.isActive == false }
        }

        // 2) Apply department multi-select
        if filter.selectedDepartments.isEmpty == false {
            result = result.filter { filter.selectedDepartments.contains($0.department) }
        }

        // 3) Apply designation multi-select
        if filter.selectedDesignations.isEmpty == false {
            result = result.filter { filter.selectedDesignations.contains($0.designation) }
        }
        // 4) Apply search (last)
        if searchText.isEmpty == false {
            let query = searchText.lowercased()

            result = result.filter {
                $0.name.lowercased().contains(query) ||
                $0.email.lowercased().contains(query) ||
                $0.department.lowercased().contains(query) ||
                $0.designation.lowercased().contains(query)
            }
        }

        return result
    }

    
    func load(forceRefresh: Bool = false) async {
        isLoading = true
        errorMessage = nil
        
        do {
//            try await Task.sleep(nanoseconds: 5_000_000_000)
            employees = try await getEmployeesUseCase.execute(forceRefresh: forceRefresh)
        } catch let error as AppError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = AppError.unknown.localizedDescription
        }
        
        isLoading = false
    }
}
