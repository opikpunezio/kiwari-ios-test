//
//  User.swift
//  TestChat
//
//  Created by Taufik Rohmat on 11/03/20.
//  Copyright © 2020 Taufik. All rights reserved.
//

import Foundation

import FirebaseFirestore

struct Member{
    
    var id: String?
    var displayName: String?
    var picture: String?
    
    init(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        id = document.documentID
        displayName = data["displayName"] as? String
        picture = data["picture"] as? String
    }
    
}
