//
//  ConversationVC.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/16/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.
//

import Foundation

class ConversationVC : UIViewController {
    
    //let firebase = Firebase(url: "https://universitymessengerapp.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NAVIGATION TITLE SET TO BUTTON
        
        let button =  UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, 100, 40) as CGRect
        button.setTitle("userFullName", forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("clickOnButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = button
        
    }
    
    func clickOnButton(button: UIButton) {
        
        let actionAlert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let image = UIAlertAction(title: "Report User", style: .Destructive) { (Alert:UIAlertAction) -> Void in
            print("Report button was pressed")
        }
        
        
        
        let block = UIAlertAction(title: "Block", style: .Destructive) { (Alert:UIAlertAction) -> Void in
            print("Block button was pressed")
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (Alert:UIAlertAction) -> Void in
            print("Cancel")
        }
        
        actionAlert.addAction(image)
        
        actionAlert.addAction(block)
        actionAlert.addAction(cancel)
        
        self.presentViewController(actionAlert, animated: true, completion: nil)
    
    
    }
    

        
    }
    
