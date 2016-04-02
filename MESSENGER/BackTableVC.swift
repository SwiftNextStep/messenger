//
//  BackTableVC.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/13/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------

// I WANT CELL TEXT AND IMAGE TO HIGHLIGHT BLUE WHEN USER SELECTS CELL. 
// THE COUNT ON THE RIGHT OF 'CONVERSATIONS' WILL DISPLAYS NUMBER OF UNREAD MESSAGES

import Foundation

class BackTableBV: UITableViewController {
    
    var cell : UITableViewCell?
    
    var fullName = String()
    var univID = String()
    
    var firebase = Firebase(url: "https://universitymessengerapp.firebaseio.com")
   
    @IBOutlet var currentUserImage: UIImageView!
    @IBOutlet var userFullName: UILabel!
    @IBOutlet var userUnivId: UILabel!
    @IBOutlet var unreadMessageCount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.firebase.childByAppendingPath("users").childByAppendingPath(self.firebase.authData.uid).observeSingleEventOfType(FEventType.Value) { (snapshot:FDataSnapshot!) -> Void in
            //self.fullName = (snapshot.value as! NSDictionary)["Full Name"] as! String
            //print(self.fullName)
            //self.univID = (snapshot.value as! NSDictionary)["UnivID"] as! String
            //print(self.univID)
            
            //self.userFullName.text = self.fullName
            //self.userUnivId.text = self.univID
        //}
        
        currentUserImage.layer.cornerRadius = currentUserImage.frame.size.width/2
        currentUserImage.clipsToBounds = true
        
        currentUserImage.layer.borderWidth = 1.0;
        currentUserImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        tableView.tableFooterView = UIView()
        // Removes empty cells in UITable View
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}


/* CHANGING UISTATUS STYLE

override func viewDidLoad() {
super.viewDidLoad()
// Do any additional setup after loading the view, typically from a nib.
}

override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}

//Changing Status Bar
override func preferredStatusBarStyle() -> UIStatusBarStyle {

//LightContent
return UIStatusBarStyle.LightContent

//Default
//return UIStatusBarStyle.Default

}

}


*/