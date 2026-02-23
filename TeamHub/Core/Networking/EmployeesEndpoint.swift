//
//  EmployeesEndpoint.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
}

enum EmployeesEndpoint: Endpoint {
    
    case employees

    var baseURL: String {
        "https://employee-static-api.onrender.com"
    }
    
    var path: String {
        switch self {
        case .employees:
            return "/employees"
        }
    }
}

extension Endpoint {
    
    func makeURL() throws -> URL {
        let full = baseURL + path
        guard let url = URL(string: full) else { throw AppError.invalidURL }
        return url
    }
}
