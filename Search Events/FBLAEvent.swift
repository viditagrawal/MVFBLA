//
//  Events.swift
//  Octagon
//
//  Created by sid on 5/26/19.
//  Copyright © 2019 sid. All rights reserved.
//

import Foundation
import MapKit

import UIKit
public class FBLAEvents{
    var date: String?
    var description: String?
    var title: String?
    var members: [String: String]?
    var numberOfMembers: Int!

    
    init(date: String, description: String, title: String){
        self.date            = date
        self.description     = description
        self.title           = title
        self.members         = [String: String]()
        self.numberOfMembers = 0

    }
    
    func printEvent(){
        print(self.date!)
        print(self.description!)
        print(self.title!)
    }
    
    func addMember(uid: String, name: String){
        members![uid] = name
        numberOfMembers = numberOfMembers + 1
    }
    
    func removeMember(uid: String, name: String){
        members?.removeValue(forKey: uid)
        numberOfMembers = numberOfMembers - 1
    }
    
    func containsUser(with user: Users) -> Bool{
        for (identification, userName) in members!{
            if(user.uid! == identification){
                return true
            }
        }
        return false
    }
    
    
    
    
    
}



