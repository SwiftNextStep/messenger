//
//  NavBar.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/17/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.
//

import Foundation

class NavBar : UINavigationController {

    override func viewDidAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()

    }
}


