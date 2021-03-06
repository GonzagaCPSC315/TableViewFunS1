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

class DogTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

