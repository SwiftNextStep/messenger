//
//  Favorites.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/16/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.



//THIS VIEW CONTROLLER WILL DISPLAY ALL USERS THE CURRENT USER HAS PREVIUOSLY MESSAGED, ARRANGED BY THE HIGHEST MESSAGE COUNT.

import Foundation

class Favorites : UITableViewController {
    
    @IBOutlet var Open: UIBarButtonItem!
    override func viewDidLoad() {
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}

