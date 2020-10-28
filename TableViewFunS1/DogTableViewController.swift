//
//  ViewController.swift
//  TableViewFunS1
//
//  Created by Gina Sprint on 10/21/20.
//  Copyright © 2020 Gina Sprint. All rights reserved.
//

import UIKit

// MARK: - Table Views
// a table view is a list of rows (AKA cells)
// 2 different ways to set up a VC with a table view
// 1. add a table view to your VC's view
// manually register the VC as the table view's data source and delegate
// you can add other views to the VC's root view
// 2. use a UITableViewController, which abstracts alot of the management for you
// you can't add any other views, because the root view is the table view
// we are going to do #1, because ADS does #2

class DogTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var dogs = [Dog]()
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initializeDogs()
    }
    
    func initializeDogs() {
        dogs.append(Dog(name: "Lassie", breed: "Collie"))
        dogs.append(Dog(name: "AirBud", breed: "Retriever"))
        dogs.append(Dog(name: "Spike", breed: "Bulldog"))
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // we are only going to have one section
        // table view is asking its data source
        // "how many rows in this section?"
        if section == 0 {
            return dogs.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // table view is asking its data source
        // "what cell should I display at this indexPath?"
        // IndexPath has 2 properties
        // section number (we can ignore this)
        // row number (corresponds to an index in our
        // underlying dog array)
        // lets get the dog at index indexPath.row
        let row = indexPath.row
        let dog = dogs[row]
        
        // now we need a DogTableViewCell!!
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogTableViewCell
        // we don't need to create a "new cell" for each our dogs and here is why
        // lets say there are 10000 dogs in our dogs array
        // we don't need 100000 cells because there won't be 10000 cells display at one time in our table view
        
        cell.update(with: dog)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "DetailSegue" {
                if let dogDetailVC = segue.destination as? DogDetailViewController {
                    // we need to get the indexPath for the row the user clicked on
                    // we need to get the dog at the row
                    // pass the dog into detailDetailVC
                    if let indexPath = tableView.indexPathForSelectedRow {
                        let dog = dogs[indexPath.row]
                        dogDetailVC.dogOptional = dog
                    }
                }
            }
        }
    }
    
    @IBAction func unwindToDogTableViewController(segue: UIStoryboardSegue) {
        // grab the dog!!
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                if let dogDetailVC = segue.source as? DogDetailViewController {
                    if let dog = dogDetailVC.dogOptional {
                        // get the currently selected index path
                        if let indexPath = tableView.indexPathForSelectedRow {
                            dogs[indexPath.row] = dog
                            // force update the table view
                            tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

