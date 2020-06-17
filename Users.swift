//
//  User.swift
//  FblaSignUpPage
//
//  Created by Sid on 1/3/20.
//  Copyright © 2020 sid. All rights reserved.
//

import Foundation


class Users{
    var name: String?
    var email: String?
    var isOfficer: Bool?
    var studentID: String?
    var uid: String?
    var gradYear: Int?
    var attendance: Int?
    
    

    
    init(name: String, email: String, isOfficer: Bool, sID: String, uid: String, gradYear: Int, attendance: Int) {
        self.name       = name
        self.email      = email
        self.isOfficer  = isOfficer
        self.studentID  = sID
        self.uid        = uid
        self.gradYear   = gradYear
        self.attendance = attendance
        
    }
    
    func equals(other: Users) -> Bool{
        if(other.email != self.email){ return false }
        if(other.name != self.name){ return false }
        if(other.uid != self.uid){ return false }
        return true
        
    }
    
    func addAttendance(){ self.attendance = attendance! + 1 }
    
    
    func printValue(){
        print(self.name!)
        print(self.email!)
        print(self.isOfficer!)
        print(self.studentID!)
        print(self.uid!)
        print(self.gradYear!)
    }
    
}
