//
//  EmployeesEndpoint.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation

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
