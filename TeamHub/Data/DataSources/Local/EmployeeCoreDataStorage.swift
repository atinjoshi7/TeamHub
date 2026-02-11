//
//  EmployeeCoreDataStorage.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation

import CoreData

final class EmployeeCoreDataSourceImpl: EmployeeLocalDataSource {
    
    private let stack: CoreDataStacking
    
    init(stack: CoreDataStacking) {
        self.stack = stack
    }
    
    func deleteAll() throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeEntity")
        let delete = NSBatchDeleteRequest(fetchRequest: fetch)
        try stack.context.execute(delete)
        try stack.saveContext()
    }
    
    func saveEmployees(_ employees: [Employee]) throws {
        
        let context = stack.context
        
        // Fetch existing employees from DB (IDs)
        let fetchRequest = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        let existingEntities = try context.fetch(fetchRequest)
        
        // Create dictionary for fast lookup: id -> entity
        var existingByID: [String: EmployeeEntity] = [:]
        existingByID.reserveCapacity(existingEntities.count)
        
        for entity in existingEntities {
            if let id = entity.id {
                existingByID[id] = entity
            }
        }
        
        // Set of existing IDs (DB)
        let existingIDs = Set(existingByID.keys)
        
        
        // Loop remote employees (Upsert)
        var incomingIDs = Set<String>()
        incomingIDs.reserveCapacity(employees.count)
        
        for employee in employees {
            
            incomingIDs.insert(employee.id)
            
            if let entity = existingByID[employee.id] {
                // Update existing
                entity.name = employee.name
                entity.designation = employee.designation
                entity.department = employee.department
                entity.isActive = employee.isActive
                entity.imgURL = employee.imgURL
                entity.email = employee.email
                entity.city = employee.city
                entity.country = employee.country
                entity.joiningDate = employee.joiningDate
                
            } else {
                // Insert new
                let newEntity = EmployeeEntity(context: context)
                newEntity.id = employee.id
                newEntity.name = employee.name
                newEntity.designation = employee.designation
                newEntity.department = employee.department
                newEntity.isActive = employee.isActive
                newEntity.imgURL = employee.imgURL
                newEntity.email = employee.email
                newEntity.city = employee.city
                newEntity.country = employee.country
                newEntity.joiningDate = employee.joiningDate
            }
        }
        
        
        // Delete employees not in API anymore
        let idsToDelete = existingIDs.subtracting(incomingIDs)
        
        if idsToDelete.isEmpty == false {
            for id in idsToDelete {
                if let entity = existingByID[id] {
                    context.delete(entity)
                }
            }
        }
        
        try stack.saveContext()
    }
    
    
    func fetchEmployees() throws -> [Employee] {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let result = try stack.context.fetch(request)
        return result.map { $0.toDomain() }
    }
    
    func fetchEmployee(by id: String) throws -> Employee? {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        
        let result = try stack.context.fetch(request)
        return result.first?.toDomain()
    }
}

private extension EmployeeEntity {
    func toDomain() -> Employee {
        Employee(
            id: id ?? "",
            name: name ?? "",
            designation: designation ?? "",
            department: department ?? "",
            isActive: isActive,
            imgURL: imgURL ?? "",
            email: email ?? "",
            city: city ?? "",
            country: country ?? "",
            joiningDate: joiningDate
        )
    }
}
