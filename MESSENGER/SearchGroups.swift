//
//  SearchGroups.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/27/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------

// THIS VIEW CONTROLLER WILL DISPLAY GROUPS IF groupUnivId = currentUserUnivId. Each created group will be assigned a UnivId.
// groupUnivId = univId of the group creator
// IF A GROUP PASSWORD IS NOT NIL, USER WILL BE PROMPTED TO ENTER A GROUP PASSWORD VIA UIALERTCONTROLLER
//  TAPPING ON A CELL OPEN GROUP INFO VIEW CONTROLLER

import Foundation

class SearchGroups : UITableViewController {
    
    var passwordAlert : UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}