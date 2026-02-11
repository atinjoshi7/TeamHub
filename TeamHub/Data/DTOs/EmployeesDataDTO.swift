//
//  EmployeesDataDTO.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation
import Combine

struct EmployeesDataDTO: Decodable {
    let employees: [EmployeeDTO]
}
