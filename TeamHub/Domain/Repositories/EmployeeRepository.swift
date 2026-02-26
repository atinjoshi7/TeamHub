//
//  EmployeeRepository.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation


protocol EmployeeRepository {
    func getEmployees(forceRefresh: Bool) async throws -> [Employee]
//    func getEmployee(by id: String) async throws -> Employee?
}
