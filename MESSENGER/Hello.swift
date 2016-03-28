//
//  Hello.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/14/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.
//

import Foundation

class Hello : UIViewController {

    override func viewDidLoad() {
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}