//
//  profileImage.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/18/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.


// THIS VC WILL DISPLAY OTHER USER'S PROFIE IMAGE WHEN IT IS TAPPED IN THE JSQ MESSAGE VIEW CONTROLLER

import Foundation

class profileImage : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button =  UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, 100, 40) as CGRect
        button.setTitle("userFullName", forState: UIControlState.Normal)
        self.navigationItem.titleView = button
    }
}