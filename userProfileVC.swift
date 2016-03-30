//
//  userProfileVC.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/17/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------

// THIS VC WILL DISPLAY CURRENT USER PROFILE INFO INCLUDING PROFILE IMAGE, FULL NAME, AND UnivId. Tapping on the Edit button (or top right navigation button) will prompt user to edit profile image or edit full name.

import Foundation

class userProfileVC : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var currentUserImage: UIImageView!
   
    var alertController : UIAlertController?
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func action(sender: AnyObject) {
    
        let actionAlert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let image = UIAlertAction(title: "Edit Image", style: .Default) { (Alert:UIAlertAction) -> Void in
            print("Edit Image button was pressed")
            
            self.imagePicker.editing = false
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
        }
        
        let name = UIAlertAction(title: "Edit Name", style: .Default) { (Alert:UIAlertAction) -> Void in
            print("Edit Name button was pressed")
            
            self.presentViewController(self.alertController!, animated: true, completion: nil)
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (Alert:UIAlertAction) -> Void in
            print("Cancel")
        }
        
        actionAlert.addAction(image)
        actionAlert.addAction(name)
        actionAlert.addAction(cancel)
        
        self.presentViewController(actionAlert, animated: true, completion: nil)
    }
    
    @IBOutlet var Open: UIBarButtonItem!
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.currentUserImage.image = image
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUserImage.layer.cornerRadius = currentUserImage.frame.size.width/2
        currentUserImage.clipsToBounds = true
        
        currentUserImage.layer.borderWidth = 1.5;
        currentUserImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        //currentUserImage.layer.borderWidth = 1.0
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //EDIT NAME ALERTVIEW CONTROLLER
        
        alertController = UIAlertController(title: "Edit Name", message: nil, preferredStyle: .Alert)
        
        let signInAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            print("Sign up button was pressed")
        }
        
        alertController?.addAction(signInAction)
        
        alertController?.addTextFieldWithConfigurationHandler({ (textfield) -> Void in
            textfield.placeholder = "Full Name"
            textfield.autocapitalizationType = UITextAutocapitalizationType.Words
            textfield.text = "User FullName"
            //TEXTFIELD.TEXT = currentUser.firstName string
        })
       
        let alertActionForTextField = UIAlertAction(title: "Save", style: .Default) { (action) -> Void in
            
            if let textFields = self.alertController?.textFields {
                let theTextFields = textFields as [UITextField]
                let fullNameTextField = theTextFields[0].text
                print("\(fullNameTextField)")
            }
        }
        alertController?.addAction(alertActionForTextField)
    }
}
