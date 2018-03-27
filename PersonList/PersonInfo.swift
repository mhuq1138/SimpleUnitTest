//
//  PersonInfo.swift
//  PersonList
//
//  Created by Mazharul Huq on 3/24/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import Foundation
public struct PersonInfo {
    let firstName: String
    let lastName: String
    let dateOfBirth: NSDate
    
    public init(firstName: String, lastName: String, dateOfBirth: NSDate) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
    }
}
