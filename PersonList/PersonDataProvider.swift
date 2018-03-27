//
//  PersonDataProvider.swift
//  PersonList
//
//  Created by Mazharul Huq on 3/24/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit
import CoreData

open class PersonDataProvider:NSObject{
    public var context:NSManagedObjectContext!
    
    override public init(){
        super.init()
        
    }
    
    public func insertPerson(_ personInfo:PersonInfo){
        let person = Person(context: self.context)
        person.firstName = personInfo.firstName
        person.lastName = personInfo.lastName
        person.dateOfBirth = personInfo.dateOfBirth
        save()
    }
    
    public func editPerson(_ person:Person, personInfo:PersonInfo){
        person.firstName = personInfo.firstName
        person.lastName = personInfo.lastName
        person.dateOfBirth = personInfo.dateOfBirth
        save()
    }
    
    public func deletePerson(_ person:Person)->Bool{
        self.context.delete(person)
        return save()
    }
    
    public func fetchAll()->[Person]{
        var persons:[Person] = []
        let fetchRequest:NSFetchRequest<Person> = Person.fetchRequest()
        do{
            persons = try self.context.fetch(fetchRequest)
        }
        catch let error as NSError{
            print("Could not save \(error),(error.userInfo)")
            return []
        }
        return persons
    }
    
    func save()->Bool{
        do {
            try self.context.save()
        } catch let nserror as NSError {
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            return false
        }
        return true
    }
 
}
