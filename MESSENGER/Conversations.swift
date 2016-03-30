//
//  Conversations.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/16/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------


// THIS VC WILL SHOW CONVERSATION BETWEEN CURRENT USER AND OTHER USERS. AS AN EXAMPLE I'VE LAID OUT A GENERAL LOOK USING A STATIC CELLS
// IMAGE WILL DISPLAY OTHER USER AVATAR IMAGE
// TAPPING ON CELLS OPEN JSQ VIEW CONTROLLER


import Foundation


class Conversations : UITableViewController {

    @IBOutlet var otherUserImage: UIImageView!
    @IBAction func SignOUT(sender: AnyObject) {
        firebase.unauth()
        
        //self.performSegueWithIdentifier("goToTerms", sender: self)
    }
    let firebase = Firebase(url: "https://universitymessengerapp.firebaseio.com/")
    
    @IBOutlet var Open: UIBarButtonItem!
 
    override func viewDidLoad() {
        
        otherUserImage.layer.cornerRadius = otherUserImage.frame.size.width/2
        otherUserImage.clipsToBounds = true

        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
}
}