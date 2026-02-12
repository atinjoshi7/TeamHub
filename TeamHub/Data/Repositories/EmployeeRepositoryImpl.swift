//
//  EmployeeRepositoryImpl.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation


final class EmployeeRepositoryImpl: EmployeeRepository {
    
    private let remote: EmployeeRemoteDataSource
    private let local: EmployeeLocalDataSource
    private let network: NetworkMonitoring
    
    init(
        remote: EmployeeRemoteDataSource,
        local: EmployeeLocalDataSource,
        network: NetworkMonitoring
    ) {
        self.remote = remote
        self.local = local
        self.network = network
    }
    
    func getEmployees(forceRefresh: Bool) async throws -> [Employee] {
        
        // If no internet => always local
        if network.isConnected == false {
        //try await Task.sleep(nanoseconds: 5_000_000_000)
            return try local.fetchEmployees()
        }
        
        // ONLINE + FORCE REFRESH
          if forceRefresh == true {
              let employees = try await remote.fetchEmployees()
              try local.saveEmployees(employees)
              return employees
          }
        
        // If internet is ON:
        // if forceRefresh is true = remote
        // else = try local first then remote
        if forceRefresh == false {
            let cached = try local.fetchEmployees()
            if cached.isEmpty == false {
                return cached
            }
        }
        
       //
        let remoteEmployees = try await remote.fetchEmployees()
        try local.saveEmployees(remoteEmployees)
        return remoteEmployees
    }
    
    func getEmployee(by id: String) async throws -> Employee? {
        
        // Try local first always (fast)
        if let localEmployee = try local.fetchEmployee(by: id) {
            return localEmployee
        }
        
        // If no internet, stop here
        if network.isConnected == false {
            return nil
        }
        
        // If you had an endpoint for single employee, call it here.
        // For now, fallback: fetch list and filter.
        let employees = try await remote.fetchEmployees()
        try local.saveEmployees(employees)
        return employees.first { $0.id == id }
    }
}
