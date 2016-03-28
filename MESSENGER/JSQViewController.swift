//
//  JSQViewController.swift
//  MESSENGER
//
//  Created by Kayamba Mukanzu on 3/25/16.
//  Copyright © 2016 Kayamba Mukanzu. All rights reserved.
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
        
        print("id:\(senderId) fullName: \(senderDisplayName)")
        //self.senderId = "uidFromFireBase"
        //self.senderDisplayName = "userFullName"
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        incomingBubble = bubbleFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
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
    
    func createAvatar(senderID: String, senderDisplayName: String, color: UIColor){
        if avatars[senderId] == nil{
            let initials = senderDisplayName.substringToIndex(senderDisplayName.startIndex.advancedBy(min(2, senderDisplayName.characters.count)))
            let avatar = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials(initials, backgroundColor: color, textColor: UIColor.blackColor(), font: UIFont.systemFontOfSize(14), diameter: UInt (kJSQMessagesCollectionViewAvatarSizeDefault))
            avatars[senderId] = avatar
        }
    }
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        //_ message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        firebase.childByAutoId().setValue(["message":text, "senderId":senderId, "senderDisplayName":senderDisplayName, "date":date.timeIntervalSince1970, "messageType": "txt"])
        //messages.append(message)
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