//
//  CoreDataStack.swift
//  PersonList
//
//  Created by Mazharul Huq on 3/24/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import Foundation
import CoreData

open class CoreDataStack {
    
    let modelName: String
    
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    public lazy var context: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    public lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    
    public func saveContext() {
        guard context.hasChanges else{
            return
        }
        do {
            try context.save()
        } catch let nserror as NSError {
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
}
