//
//  EmployeeRepository.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation


protocol EmployeeRepository {
    var newEmployeesCount: Int { get }
    func getEmployees(forceRefresh: Bool) async throws -> [Employee]
}
