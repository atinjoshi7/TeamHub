//
//  CoreDataStack.swift
//  TeamHub
//
//  Created by Jarvis on 11/02/26.
//

import Foundation
import CoreData

protocol CoreDataStacking {
    var context: NSManagedObjectContext { get }
    func saveContext() throws
}

final class CoreDataStack: CoreDataStacking {
    
    static let shared = CoreDataStack()
    
    private let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: "EmployeesDB")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData failed: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func saveContext() throws {
        let ctx = container.viewContext
        if ctx.hasChanges {
            try ctx.save()
        }
    }
}
