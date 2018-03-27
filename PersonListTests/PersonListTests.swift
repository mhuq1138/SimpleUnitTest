//
//  PersonListTests.swift
//  PersonListTests
//
//  Created by Mazharul Huq on 3/25/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import XCTest
import PersonList
import CoreData

class PersonListTests: XCTestCase {
    var coreDataStack:CoreDataStack!
    var dataProvider:PersonDataProvider!
    
    override func setUp() {
        super.setUp()
        self.dataProvider = PersonDataProvider()
        self.coreDataStack = TestCoreDataStack()
        self.dataProvider.context = coreDataStack.context
        self.seedStore()
    }
    
    override func tearDown() {
        super.tearDown()
        self.dataProvider = nil
        self.coreDataStack = nil
    }
    
    func testThatStoreIsSetUp(){
        XCTAssertNotNil(self.coreDataStack.storeContainer,"No persistent store")
    }
    
    func testRecordCount(){
        XCTAssertEqual(self.noOfRecordsInStore(), 3)
    }
    
    func testDeleteRecord(){
        let persons = self.dataProvider.fetchAll()
        let person = persons[1]
        if self.dataProvider.deletePerson(person) == true{
            XCTAssertEqual(self.noOfRecordsInStore(), 2)
        }
    }
    
    func testInsertRecord(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let person = PersonInfo(firstName: "Henry", lastName: "Higgins", dateOfBirth: dateFormatter.date(from: "09-12-1920")! as NSDate)
        self.dataProvider.insertPerson(person)
        XCTAssertEqual(self.noOfRecordsInStore(), 4)
    }
    
    func testUpdateRecord(){
        var persons = self.dataProvider.fetchAll()
        let person = persons[0]
        let editedPerson = PersonInfo(firstName: "Jack", lastName: "Hugh", dateOfBirth: person.dateOfBirth!)
        self.dataProvider.editPerson(person, personInfo: editedPerson)
        persons = self.dataProvider.fetchAll()
        let person1 = persons[0]
        XCTAssertTrue(person1.firstName == "Jack")
        XCTAssertTrue(person1.lastName == "Hugh")
    }
    
    
    func seedStore(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let person1 = PersonInfo(firstName: "John", lastName: "Hawkings", dateOfBirth: dateFormatter.date(from: "01-12-2001")! as NSDate)
        let person2 = PersonInfo(firstName: "Mary", lastName: "Roberts", dateOfBirth: dateFormatter.date(from: "03-12-2005")! as NSDate)
        let person3 = PersonInfo(firstName: "Bob", lastName: "Miller", dateOfBirth: dateFormatter.date(from: "07-19-1978")! as NSDate)
        self.dataProvider.insertPerson(person1)
        self.dataProvider.insertPerson(person2)
        self.dataProvider.insertPerson(person3)
        
    }
    
    func noOfRecordsInStore()->Int{
        let persons = self.dataProvider.fetchAll()
        return persons.count
    }
    
}
