//
//  Directory.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/16/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.
//

import Foundation

class Directory : UITableViewController {
    
    @IBOutlet var Open: UIBarButtonItem!

        override func viewDidLoad() {
            
            Open.target = self.revealViewController()
            Open.action = Selector("revealToggle:")
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
}