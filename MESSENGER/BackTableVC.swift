//
//  BackTableVC.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/13/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------


import Foundation

class BackTableBV: UITableViewController {
    
    var cell : UITableViewCell?
    
   
    @IBOutlet var currentUserImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theWidth = view.frame.size.height
        
        currentUserImage.center = CGPointMake(theWidth/2, 120)
        currentUserImage.layer.cornerRadius = currentUserImage.frame.size.width/2
        currentUserImage.clipsToBounds = true
        
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