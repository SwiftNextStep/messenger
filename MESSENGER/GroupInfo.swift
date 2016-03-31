//
//  GroupInfo.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/29/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------

// CUSTOM CREATING A UIALERTVIEW.
// CREATOR OF GROUP IS AUTOMATICALLY ADDED TO GROUP AND WILL ONLY HAVE ALERT OPTION TO DELETE GROUP
// IF GROUP CREATOR IS NOT SELF, ALERT OPTION IS 'JOIN GROUP' OR 'LEAVE GROUP' AND 'REPORT GROUP'.
// IF GROUP CREATOR IS SELF, ALERT OPTION IS EDIT PASSWORD OR DELETE GROUP

import Foundation

class GroupInfo : UITableViewController {
    
    var actionAlert : UIAlertController?

    @IBAction func Option(sender: AnyObject) {
        
        let actionAlert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let joinGroup = UIAlertAction(title: "Join Group", style: .Default) { (Alert:UIAlertAction) -> Void in
            print("Join Group button was pressed")
        
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (Alert:UIAlertAction) -> Void in
            print("Cancel")
        }
        actionAlert.addAction(joinGroup)
        actionAlert.addAction(cancel)
        
        self.presentViewController(actionAlert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}