//
//  Constants.swift
//  FblaSignUpPage
//
//  Created by sid on 5/26/19.
//  Copyright © 2019 sid. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth


struct constantVal{
    //static var allUsers:[Users] = []
    static var allEvents: [FBLAEvents] = []
    static var allUsers = [String: Users]()
    static var currentUID: String = ""
    static var wasAbleToAuth = true
    static var backgroundColor = UIColor(red: 32/255, green: 127/255, blue: 198/255, alpha: 1.0)
    
}
