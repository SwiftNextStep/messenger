//
//  Goups.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/27/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------

// THIS VIEW CONTROLLER WILL DISPLAY GROUPS THAT THE CURRENT USER HAS JOINED. THE OPTIONS BUTTON (OR TOP RIGHT NAV ITEM) PROMPTS THE USER TO SEARCH GROUPS OR CREATE A GROUP.
// TAPPING ON A CELL WILL OPENS GROUP INFO VIEW CONTROLLER

import Foundation

class Groups : UITableViewController {
    
    let firebase = Firebase(url: "https://universitymessengerapp.firebaseio.com/")
    
    var createGroupAlert : UIAlertController?
    
    var univID = String()
    var groupName = String()
    var groupPassword = String()
    var fullName = String()
    
    @IBAction func Options(sender: AnyObject) {
        
        let actionAlert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let searchGroup = UIAlertAction(title: "Search Groups", style: .Default) { (Alert:UIAlertAction) -> Void in
            print("Search Groups button was pressed")
            
            self.performSegueWithIdentifier("goToGroupSearch", sender: self)
        }
        let createGroup = UIAlertAction(title: "Create Group", style: .Default) { (Alert:UIAlertAction) -> Void in
            print("Create Group button was pressed")
            self.presentViewController(self.createGroupAlert!, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (Alert:UIAlertAction) -> Void in
            print("Cancel")
        }
        actionAlert.addAction(searchGroup)
        actionAlert.addAction(createGroup)
        actionAlert.addAction(cancel)
        
        self.presentViewController(actionAlert, animated: true, completion: nil)
    }
    
    @IBOutlet var Open: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        createGroupAlert = UIAlertController(title: "New Group", message: "Give your group a unique name.", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action:UIAlertAction!) -> Void in
            print("Cancel button was pressed")
        }
        self.createGroupAlert?.addAction(cancel)
        
        createGroupAlert?.addTextFieldWithConfigurationHandler({ (textfield) -> Void in
            textfield.placeholder = "Group Name"
            textfield.text = ""
        })
        
        createGroupAlert?.addTextFieldWithConfigurationHandler({ (textfield) -> Void in
            textfield.placeholder = "Password (Optional)"
            textfield.text = ""
            textfield.secureTextEntry = true
        })
        
        //EACH GROUP CREATED IS ASSIGNED A UnivID. groupUnivId = currentUserUnivId
        
        let alertActionForTextFields = UIAlertAction(title: "Create", style: .Default) { (action) -> Void in
            
            if let textFields = self.createGroupAlert?.textFields {
                let theTextFields = textFields as [UITextField]
                let groupNameTextField = theTextFields[0].text
                print("\(groupNameTextField)")
                
                let passwordTextField = theTextFields[1].text
                print("\(passwordTextField)")
                
                self.groupName = groupNameTextField!
                self.groupPassword = passwordTextField!
                
                self.firebase.childByAppendingPath("users").childByAppendingPath(self.firebase.authData.uid).observeSingleEventOfType(FEventType.Value, withBlock: { (snapshot:FDataSnapshot!) -> Void in
                    self.univID = (snapshot.value as! NSDictionary)["UnivID"] as! String
                    print(self.univID)
                    
                 self.firebase.childByAppendingPath("Groups").childByAutoId().setValue(["Group Name":self.groupName, "Group Password":self.groupPassword, "Creator": self.firebase.authData.uid, "UnivID":self.univID])
                })
            }
        }
        
        createGroupAlert?.addAction(alertActionForTextFields)
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}