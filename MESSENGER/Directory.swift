//
//  Directory.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/16/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------

// THIS VIEW CONTROLLER WILL DISPLAY USERS IF currentUserUnivId = otherUserUnivId. For example, if the current user UnivdId is @havard.edu, the directory will only display only users with domain equal to @havard.ed.
// TAPPING ON A CELL WILL OPENs JSQ VIEW CONTROLLER

// UnivID is created in the Auth view controller using the following code.             
// let domain = emailTextField!.componentsSeparatedByString("@")[1]
// let univID = "@" + domain


import Foundation

class Directory : UITableViewController {
    
    var firebase : Firebase!
    
    var items = [FDataSnapshot]()
    
    var fullName = String()
    
    @IBOutlet var Open: UIBarButtonItem!
    @IBOutlet var searchBar: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebase = Firebase(url: "https://universitymessengerapp.firebaseio.com/users")
        

        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
            
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.firebase.observeEventType(FEventType.ChildAdded, withBlock: { snapshot in
            
            self.fullName = (snapshot.value as! NSDictionary)["Full Name"] as! String
            print(self.fullName)
            
            self.tableView.reloadData()
            
        })
        
        }
    }














/*
tableView.tableFooterView = UIView()

myDirectory = ["Jonathan Wells","Peter Weller","Sam Smith","Andrew Mavrick"]

self.firebase.observeEventType(FEventType.ChildAdded, withBlock: { snapshot in

self.fullName = (snapshot.value as! NSDictionary)["Full Name"] as! String
print(self.fullName)

})

Open.target = self.revealViewController()
Open.action = Selector("revealToggle:")

self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
}

override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
}

override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return myDirectory.count
}

override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
let Cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

Cell.textLabel?.text = myDirectory[indexPath.row]

return Cell
}
}



*/