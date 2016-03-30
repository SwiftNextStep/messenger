//
//  Directory.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/16/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------

// THIS VIEW CONTROLLER WILL DISPLAY USERS IF currentUserUnivId = otherUserUnivId. For example, if the current user UnivdId is @havard.edu, the directory will only display only users with domain equal to @havard.ed.
// TAPPING ON A CELL WILL OPENs JSQ VIEW CONTROLLER

// UnivID is created in the Auth view controller using the following code.             
// let domain = emailTextField!.componentsSeparatedByString("@")[1]
// let univID = "@" + domain




import Foundation

class Directory : UITableViewController {
    
    @IBOutlet var Open: UIBarButtonItem!

        override func viewDidLoad() {
            
            Open.target = self.revealViewController()
            Open.action = Selector("revealToggle:")
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
}