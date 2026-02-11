//
//  EmployeeDTO.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation

struct EmployeeDTO: Decodable {
    let id: String
    let name: String
    let designation: String
    let department: String
    let isActive: Bool
    let imgURL: String?
    let email: String
    let city: String
    let country: String
    let joiningDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, name, designation, department, email, city, country
        case isActive = "is_active"
        case imgURL = "img_url"
        case joiningDate = "joining_date"
    }
}


extension EmployeeDTO {
    func toDomain() -> Employee {
        Employee(
            id: id,
            name: name,
            designation: designation,
            department: department,
            isActive: isActive,
            imgURL: imgURL ?? "",
            email: email,
            city: city,
            country: country,
            joiningDate: joiningDate
        )
    }
}
