//
//  JSQViewController.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/25/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.

//----------------------------------------------------------------------------

// I DON'T FULLY UNDERSTAND HOW TO CONNECT THE JSQ VC. WHAT I WOULD LIKE TO ACHIEVE.. TAPPING ON A CELL IN THE FOLLOWING VIEW CONTROLLERS WILL OPEN JSQ VIEW CONTROLLER: Conversations, Favorites, Directory, and Groupinfo.

// THIS VC WILL DISPLAY THE CONVERSATION BETWEEEN CURRENT USER AND OTHER USER.
// THE TOP RIGHT NAV BAR ITEM WILL DISPLAY OTHER USER AVATAR IMAGE. CLICKING IMAGE WILL ENLARGE IT
// NAV TITLE IS A CLICKABLE BUTTON THAT WILL OPEN AN ACTION ALERT. CURRENT USER CAN REPORT OR BLOCK OTHER USER.
// 

import Foundation

class JSQViewController: JSQMessagesViewController {
    
    var incomingBubble : JSQMessagesBubbleImage!
    var outgoingBubble  : JSQMessagesBubbleImage!
    
    var avatars = [String:JSQMessagesAvatarImage]()
    
    var messages = [JSQMessage]()
    var keys = [String]()
    
    let firebase = Firebase(url: "https://universitymessengerapp.firebaseio.com/JSQNode")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CHANGES NAVIGATION TITLE INTO A CLIKABLE BUTTON
        let button =  UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, 100, 40) as CGRect
        button.setTitle("userFullName", forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("clickOnButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = button

        print("id:\(senderId) fullName: \(senderDisplayName)")
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        incomingBubble = bubbleFactory.incomingMessagesBubbleImageWithColor(UIColor.grayColor())
        outgoingBubble = bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        
        createAvatar(senderId, senderDisplayName: senderDisplayName, color: UIColor.lightGrayColor())
        firebase.queryLimitedToLast(50).observeSingleEventOfType(FEventType.Value) { (snapshot:FDataSnapshot!) -> Void in
            let values = snapshot.value
            for value in values as! NSDictionary {
                self.keys.append(value.key as! String)
                if let message = value.value as? NSDictionary {
                    let date = message["date"] as! NSTimeInterval
                    let receiveSenderId = message["senderId"] as! String
                    let receiveDisplayName = message["senderDisplayName"] as! String
                    self.createAvatar(receiveSenderId, senderDisplayName: receiveDisplayName, color: UIColor.lightGrayColor())
                    let jsqMessage = JSQMessage(senderId: receiveSenderId, senderDisplayName: receiveDisplayName, date:NSDate(timeIntervalSince1970: date) , text: message["message"] as! String)
                    self.messages.append(jsqMessage)
                }
                
                self.finishReceivingMessageAnimated(true)
                
            }
        }
        firebase.queryLimitedToLast(1).observeEventType(FEventType.ChildAdded) { (snapshot:FDataSnapshot!) -> Void in
            self.keys.append(snapshot.key)
            if let message = snapshot.value as? NSDictionary {
                let date = message["date"] as! NSTimeInterval
                let receiveSenderId = message["senderId"] as! String
                let receiveDisplayName = message["senderDisplayName"] as! String
                self.createAvatar(receiveSenderId, senderDisplayName: receiveDisplayName, color: UIColor.jsq_messageBubbleGreenColor())
                
                let jsqMessage = JSQMessage(senderId: receiveSenderId, senderDisplayName: receiveDisplayName, date:NSDate(timeIntervalSince1970: date) , text: message["message"] as! String)
                self.messages.append(jsqMessage)
                if receiveSenderId != self.senderId {
                    JSQSystemSoundPlayer.jsq_playMessageReceivedSound()
                }
                
            }
            
            self.finishReceivingMessageAnimated(true)
            
        }
        
    }
    
    func clickOnButton(button: UIButton) {
        // NAVIGATION TITLE ALERT
        
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
    
    func createAvatar(senderID: String, senderDisplayName: String, color: UIColor){
        if avatars[senderId] == nil{
            let initials = senderDisplayName.substringToIndex(senderDisplayName.startIndex.advancedBy(min(2, senderDisplayName.characters.count)))
            let avatar = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials(initials, backgroundColor: color, textColor: UIColor.blackColor(), font: UIFont.systemFontOfSize(14), diameter: UInt (kJSQMessagesCollectionViewAvatarSizeDefault))
            avatars[senderId] = avatar
        }
    }
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {

        firebase.childByAutoId().setValue(["message":text, "senderId":senderId, "senderDisplayName":senderDisplayName, "date":date.timeIntervalSince1970, "messageType": "txt"])

        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        finishSendingMessage()
    }
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.row]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = messages[indexPath.row]
        if message.senderId == senderId{
            return outgoingBubble
        }
        return incomingBubble
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        let message = messages[indexPath.row]
        
        return avatars[message.senderId]
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.row]
        if message.senderId == senderId{
            cell.textView?.textColor = UIColor.blackColor()
        }else{
            cell.textView?.textColor = UIColor.whiteColor()
        }
        
        cell.textView?.linkTextAttributes = [NSForegroundColorAttributeName:(cell.textView?.textColor)!]
        
        return cell
        
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        
        let message = messages[indexPath.row]
        if indexPath.row <= 1 {
            return NSAttributedString(string: message.senderDisplayName)
        }
        return nil
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
        }
    }