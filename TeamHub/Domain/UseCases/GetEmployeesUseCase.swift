//
//  GetEmployeesUseCase.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation


protocol GetEmployeesUseCase {
    func execute(forceRefresh: Bool) async throws -> [Employee]
}

final class GetEmployeesUseCaseImpl: GetEmployeesUseCase {
    
    private let repository: EmployeeRepository
    
    init(repository: EmployeeRepository) {
        self.repository = repository
    }
    
    func execute(forceRefresh: Bool) async throws -> [Employee] {
        try await repository.getEmployees(forceRefresh: forceRefresh)
    }
}
