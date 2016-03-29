//
//  Settings.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/16/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------

// I'M UNABLE TO UNAUTH USER BY CLICKING SIGN OUT ON CELLS.
// I'M UNABLE TO ADD ACTION SHEET TO 'INVITE A FRIEND' CELL. MESSAGE, MAIL, CANCEL.
// TAPPING ON 'REPORT A PROBLEM' WILL OPEN JSQ CONVERSATION WILL ADMIN

import Foundation

class Settings : UITableViewController {
    
    @IBOutlet var signOut: UITableViewCell!
    
    let firebase = Firebase(url: "https://universitymessengerapp.firebaseio.com/")
    
    @IBOutlet var Open: UIBarButtonItem!
    override func viewDidLoad() {
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}