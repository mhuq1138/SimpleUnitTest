//
//  TestCoreDataStack.swift
//  PersonListTests
//
//  Created by Mazharul Huq on 3/25/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import PersonList
import Foundation
import CoreData

class TestCoreDataStack: CoreDataStack {
    convenience init() {
        self.init(modelName: "PersonList")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        self.storeContainer = container
    }
    
}

