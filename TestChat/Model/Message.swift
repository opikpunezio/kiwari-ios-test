//
//  Message.swift
//  TestChat
//
//  Created by Taufik Rohmat on 11/03/20.
//  Copyright © 2020 Taufik. All rights reserved.
//

import Firebase
import MessageKit
import FirebaseFirestore

struct Message : MessageType{
    
    let id: String?
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    var sender: SenderType
    var sentDate: Date
    var kind: MessageKind
    var text: String
    
    
    init(_ text: String, user: User) {
        self.kind = .text(text)
        self.sender = Sender(id: user.uid, displayName: user.displayName!)
        self.id = nil
        self.sentDate = Date()
        self.text = text
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let sentDate = data["created"] as? Timestamp else {
            return nil
        }
        guard let senderID = data["senderID"] as? String else {
            return nil
        }
        guard let senderName = data["senderName"] as? String else {
            return nil
        }
        
        id = document.documentID
        
        self.sentDate = sentDate.dateValue()

        sender = Sender(id: senderID, displayName: senderName)
        self.text = data["content"] as! String
        self.kind = .text(self.text)
    }
    
    var representation: [String : Any] {
        var rep: [String : Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName
        ]
        
        rep["content"] = text
        
        return rep
    }
}


extension Message: Comparable {
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
    
}
