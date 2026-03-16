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
    private(set) var newEmployeesCount: Int = 0
    private var currentPage = 0
    private let pageSize = 20
    private var hasMoreFromAPI = true
    
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

            let remoteEmployees = try await remote.fetchEmployees()
            let localEmployees = try local.fetchEmployees()

            // FIRST LAUNCH → don't count new employees
            if localEmployees.isEmpty {
                newEmployeesCount = 0
            } else {
                let localIDs = Set(localEmployees.map { $0.id })
                let remoteIDs = Set(remoteEmployees.map { $0.id })

                let newEmployees = remoteIDs.subtracting(localIDs)
                self.newEmployeesCount = newEmployees.count
            }

            try local.saveEmployees(remoteEmployees)

            return try local.fetchEmployees()
        }

        // If internet is ON:
        // if forceRefresh is false = try local first
        let cached = try local.fetchEmployees()

        if forceRefresh == false && cached.isEmpty == false {

            // check API for new employees
            let remoteEmployees = try await remote.fetchEmployees()

            let localIDs = Set(cached.map { $0.id })
            let remoteIDs = Set(remoteEmployees.map { $0.id })

            let newEmployees = remoteIDs.subtracting(localIDs)

            self.newEmployeesCount = newEmployees.count

            return cached
        }
        // Remote fallback
        let remoteEmployees = try await remote.fetchEmployees()
        let localEmployees = try local.fetchEmployees()

        // FIRST LAUNCH → don't count new employees
        if localEmployees.isEmpty {
            newEmployeesCount = 0
        } else {
            let localIDs = Set(localEmployees.map { $0.id })
            let remoteIDs = Set(remoteEmployees.map { $0.id })

            let newEmployees = remoteIDs.subtracting(localIDs)
            self.newEmployeesCount = newEmployees.count
        }

        try local.saveEmployees(remoteEmployees)

        return try local.fetchEmployees()
    }
}
