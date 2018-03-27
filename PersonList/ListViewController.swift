//
//  ListViewController.swift
//  PersonList
//
//  Created by Mazharul Huq on 3/23/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UITableViewController {
    var dataProvider: PersonDataProvider!
    lazy var coreDataStack = CoreDataStack(modelName: "PersonList")
    
    var persons:[Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = PersonDataProvider()
        dataProvider.context = self.coreDataStack.context

        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        persons = dataProvider.fetchAll()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let person = persons[indexPath.row]
        
        cell.textLabel?.text = person.value(forKey: "lastName") as? String
        var firstName = ""
        if let name = person.value(forKey: "firstName") as? String{
            firstName = name
        }
        var dobString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        if let date = person.value(forKey: "dateOfBirth") as? Date{
            dobString = "  DOB: \(dateFormatter.string(from: date))"
        }
        cell.detailTextLabel?.text = firstName + dobString

        return cell
    }
 
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = persons[indexPath.row]
            if dataProvider.deletePerson(person){
                persons.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! UINavigationController
        let vc = nvc.topViewController as! EditViewController
        vc.dataProvider = self.dataProvider
        if segue.identifier == "editSegue"{
            vc.titleString = "Update Person"
            if let indexPath = self.tableView.indexPathForSelectedRow{
                vc.person = self.persons[indexPath.row]
            }
        }
        else{
            vc.titleString = "Insert Person"
        }
    }
}
