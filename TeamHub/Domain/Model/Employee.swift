//
//  Employee.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation

struct Employee: Identifiable, Equatable, Hashable{
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
}
