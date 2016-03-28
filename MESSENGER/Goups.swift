//
//  Goups.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/27/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.
//

import Foundation

class Groups : UITableViewController {
    
    @IBAction func Options(sender: AnyObject) {
        
        let actionAlert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let searchGroup = UIAlertAction(title: "Search Groups", style: .Default) { (Alert:UIAlertAction) -> Void in
            print("Search Groups button was pressed")
        }
        let createGroup = UIAlertAction(title: "Create Group", style: .Default) { (Alert:UIAlertAction) -> Void in
            print("Create Group button was pressed")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (Alert:UIAlertAction) -> Void in
            print("Cancel")
        }
        actionAlert.addAction(searchGroup)
        actionAlert.addAction(createGroup)
        actionAlert.addAction(cancel)
        
        self.presentViewController(actionAlert, animated: true, completion: nil)
        
    }

    @IBOutlet var Open: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
    }
    
}