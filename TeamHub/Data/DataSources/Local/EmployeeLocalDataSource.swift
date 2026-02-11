//
//  EmployeeLocalDataSource.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation
import Foundation

protocol EmployeeLocalDataSource {
    func saveEmployees(_ employees: [Employee]) throws
    func fetchEmployees() throws -> [Employee]
    func fetchEmployee(by id: String) throws -> Employee?
    func deleteAll() throws
}
