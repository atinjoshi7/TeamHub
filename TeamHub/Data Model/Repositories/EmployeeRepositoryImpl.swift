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
            return try local.fetchEmployees()
        }
        
        // ONLINE + FORCE REFRESH
          if forceRefresh == true {
              
              let employees = try await remote.fetchEmployees()
              try local.saveEmployees(employees)
              return try local.fetchEmployees()
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
        
        let remoteEmployees = try await remote.fetchEmployees()
        try local.saveEmployees(remoteEmployees)
        return try local.fetchEmployees()
    }
    
}
