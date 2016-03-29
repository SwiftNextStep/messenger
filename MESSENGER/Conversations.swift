//
//  Conversations.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/16/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------

// THIS VC WILL SHOW CONVERSATION BETWEEN CURRENT USER AND OTHER USERS. I'VE LAID OUT A GENERAL LOOK USING A STATIC CELL
// THE USER WILL ALSO SIGN UP AND SIGN IN ON THIS VC VIA POP-UP UIALERTCONTROLLERS.

import Foundation


class Conversations : UITableViewController {

    @IBAction func SignOUT(sender: AnyObject) {
        firebase.unauth()
        
        self.presentViewController(self.alertController!, animated: true, completion: nil)
    }
    let firebase = Firebase(url: "https://universitymessengerapp.firebaseio.com/")
    var userEmail = String()
    var userUnivId = String()
    var fullname = String()
    var passWord = String()
    
    @IBOutlet var Open: UIBarButtonItem!
    var alertController : UIAlertController?
    var newAccountAlert : UIAlertController?
    var emailVerificationAlert : UIAlertController?
    var signInAlert : UIAlertController?
    var resetPasswordAlert : UIAlertController?
    var passwordReset : UIAlertController?
    var passwordHasReset : UIAlertController?
 
    override func viewDidLoad() {
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        passwordHasReset = UIAlertController(title: "Password Reset Successful", message: "We've emailed you a temporary password.", preferredStyle: .Alert)
        let dismiss = UIAlertAction(title: "OK", style: .Cancel) { (action) -> Void in
            print("Ok button was pressed")
            
            self.presentViewController(self.signInAlert!, animated: true, completion: nil)
            
        }
        passwordHasReset?.addAction(dismiss)
        
        passwordReset = UIAlertController(title: "Email", message: "Forgot your password? We'll email you a temporary password.", preferredStyle: .Alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            print("Cancel button was pressed")
            self.presentViewController(self.signInAlert!, animated: true, completion: nil)
        }
        passwordReset?.addAction(cancelButton)
        
        passwordReset?.addTextFieldWithConfigurationHandler({ (textfield) -> Void in
            textfield.placeholder = "Email"
            textfield.text = ""
        })
        
        let alertActionForTextFieldss = UIAlertAction(title: "Reset", style: .Default) { (action) -> Void in
            print("Reset button was pressed")
            self.presentViewController(self.passwordHasReset!, animated: true, completion: nil)
            
            if let textFields = self.passwordReset?.textFields {
                let theTextFields = textFields as [UITextField]
                let emailTextField = theTextFields[0].text
                print("\(emailTextField)")
            }
        }
        
        passwordReset?.addAction(alertActionForTextFieldss)
        
        signInAlert = UIAlertController(title: "Sign in", message: "Please enter your email and password.", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "Reset Password", style: .Default) { (action) -> Void in
            print("Reset password button was pressed")
            self.presentViewController(self.passwordReset!, animated: true, completion: nil)

        }
        signInAlert?.addAction(cancel)
        
        signInAlert?.addTextFieldWithConfigurationHandler({ (textfield) -> Void in
            textfield.placeholder = "Email"
            textfield.text = ""
        })
        
        signInAlert?.addTextFieldWithConfigurationHandler({ (textfield) -> Void in
            textfield.placeholder = "Password"
            textfield.text = ""
            textfield.secureTextEntry = true
        })
        
        let alertActionForTextFields = UIAlertAction(title: "Sign in", style: .Default) { (action) -> Void in
            
            if let textFields = self.signInAlert?.textFields {
                let theTextFields = textFields as [UITextField]
                let emailTextField = theTextFields[0].text
                print("\(emailTextField)")
                
                let passwordTextField = theTextFields[1].text
                print("\(passwordTextField)")
                
                self.firebase.authUser(emailTextField, password: passwordTextField, withCompletionBlock: { (error:NSError!, authData:FAuthData!) -> Void in
                    if error != nil {
                        print(error.localizedDescription)
                    } else {
                        print("user logged in\(authData.description)")
                    }
                })
                
                //LOGGIN USER IN
            }
        }
        
        signInAlert?.addAction(alertActionForTextFields)
        
        emailVerificationAlert = UIAlertController(title: "Email Verification", message: "We've sent you a temporary password. Check your email and then proceed to log in.", preferredStyle: .Alert)
        let done = UIAlertAction(title: "Done", style: .Default) { (action) -> Void in
            print("OK button was pressed")
            self.presentViewController(self.signInAlert!, animated: true, completion: nil)
        }
        
        emailVerificationAlert?.addAction(done)
        
        tableView.tableFooterView = UIView()
        
        newAccountAlert = UIAlertController(title: "Sign up", message: "By tapping 'Sign up' you are agreeing to our terms of service.", preferredStyle: .Alert)
        
        let terms = UIAlertAction(title: "Terms of Service", style: .Default) { (action:UIAlertAction!) -> Void in
            print("terms button was pressed")
            
            self.performSegueWithIdentifier("goToTerms", sender: self)
            
        }
        
        newAccountAlert?.addAction(terms)
        
        newAccountAlert?.addTextFieldWithConfigurationHandler({ (textfield) -> Void in
            textfield.placeholder = "Full Name"
            textfield.text = ""
        })
        
        newAccountAlert?.addTextFieldWithConfigurationHandler({ (textfield) -> Void in
            textfield.placeholder = "Email"
            textfield.text = ""
        })
        
        let alertActionForTextField = UIAlertAction(title: "Sign up", style: .Default) { (action) -> Void in
            self.presentViewController(self.emailVerificationAlert!, animated: true, completion: nil)
            
            if let textFields = self.newAccountAlert?.textFields {
                let theTextFields = textFields as [UITextField]
                let fullNameTextField = theTextFields[0].text
                print("\(fullNameTextField)")
                
                let emailTextField = theTextFields[1].text
                print("\(emailTextField)")
                let domain = emailTextField!.componentsSeparatedByString("@")[1]
                let univID = "@" + domain
                print("User univID is \(univID)")
                let userPassword = "0"
                print("\(userPassword)")
                
                //ADDING NEW USER TO FIREBASE
                
                self.firebase.createUser(emailTextField, password: userPassword, withCompletionBlock: { (error:NSError!) -> Void in
                    self.firebase.authUser(emailTextField, password: userPassword, withCompletionBlock: { (error:NSError!, authData:FAuthData!) -> Void in
                        print("\(authData.description)")
                        let uid = authData.uid
                        self.userUnivId = univID
                        self.userEmail = emailTextField!
                        self.fullname = fullNameTextField!
                        self.firebase.childByAppendingPath("users").childByAppendingPath(uid).setValue(["Full Name":self.fullname,"Email":self.userEmail,"UnivID":self.userUnivId])
                        
                    })
                })
            }
        }
        
        newAccountAlert?.addAction(alertActionForTextField)
        
        alertController = UIAlertController(title: "Hello", message: "What would you like to do?", preferredStyle: .Alert)
        
        let signInAction = UIAlertAction(title: "Sign in", style: .Default) { (action) -> Void in
            print("Sign up button was pressed")
            self.presentViewController(self.signInAlert!, animated: true, completion: nil)
        }
        let signUpAction = UIAlertAction(title: "Sign up", style: .Default) { (action) -> Void in
            print("Sign in button was pressed")
            
            self.presentViewController(self.newAccountAlert!, animated: true, completion: nil)

        }
        alertController?.addAction(signInAction)
        
        alertController?.addAction(signUpAction)
    
        }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "segueJSQ"{
                if let viewcontroller = segue.destinationViewController as? JSQViewController{
                viewcontroller.senderId = self.firebase.authData.uid
                viewcontroller.senderDisplayName = self.fullname
                }
            }
        }
        func retriveUSerName(){
            self.firebase.childByAppendingPath("users").childByAppendingPath(firebase.authData.uid).observeSingleEventOfType(.Value) { (snapshot:FDataSnapshot!) -> Void in
            self.fullname = (snapshot.value as! NSDictionary)["Full Name"] as! String
            }
        }
        override func viewDidAppear(animated: Bool) {
            super.viewDidAppear(animated)
        
            //KEEP USER LOGGED IN
        
            if firebase.authData != nil{
                self.retriveUSerName()
            
                } else{
            
            self.presentViewController(alertController!, animated: true, completion: nil)
                }
            }
        }

