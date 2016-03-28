//
//  Goups.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/27/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.
//

import Foundation

class Groups : UITableViewController {
    
    @IBOutlet var Open: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
    }
    
}