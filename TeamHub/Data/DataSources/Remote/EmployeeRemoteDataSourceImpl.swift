//
//  EmployeeRemoteDataSourceImpl.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation

final class EmployeeRemoteDataSourceImpl: EmployeeRemoteDataSource {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchEmployees() async throws -> [Employee] {
        let response: EmployeesResponseDTO = try await apiClient.request(EmployeesEndpoint.employees)
        return response.data.employees.map { $0.toDomain() }
    }
}
