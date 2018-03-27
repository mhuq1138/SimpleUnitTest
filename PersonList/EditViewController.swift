//
//  EditViewController.swift
//  PersonList
//
//  Created by Mazharul Huq on 3/23/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var dobField: UITextField!
    
    var dataProvider:PersonDataProvider!
    var person:Person?
    var titleString = ""
    var dateFormatter:DateFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = titleString
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        self.firstNameField.text = person?.value(forKey: "firstName") as? String
        self.lastNameField.text = person?.value(forKey: "lastName") as? String
        if let dob = person?.value(forKey: "dateOfBirth") as? Date{
            self.dobField.text = dateFormatter.string(from: dob)
        }
    }

    
    @IBAction func saveTapped(_ sender: Any) {
        var personInfo:PersonInfo
        let firstName = self.firstNameField.text
        let lastName = self.lastNameField.text
        let dob = dateFormatter.date(from: dobField.text!) as NSDate?
        personInfo = PersonInfo(firstName: firstName!, lastName: lastName!, dateOfBirth: dob!)
        if self.person == nil{
            self.dataProvider.insertPerson(personInfo)
        }
        else{
            self.dataProvider.editPerson(self.person!, personInfo: personInfo)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
