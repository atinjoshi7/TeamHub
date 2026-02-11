//
//  EmployeesResponseDTO.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation
import Combine
struct EmployeesResponseDTO: Decodable {
    let status: String
    let message: String
    let data: EmployeesDataDTO
}

