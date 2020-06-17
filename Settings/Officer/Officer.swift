//
//  Officer.swift
//  FBLA-Officer-Page
//
//  Created by Sid on 11/23/19.
//  Copyright © 2019 Sid. All rights reserved.
//

import Foundation
import UIKit

public class Officer{
    var name: String!
    var grade: Int!
    var title: String!
    var summary: String!
    var imageName: String!
    
    init(name: String, grade: Int, title: String, about: String, img_name: String) {
        self.name       = name
        self.grade      = grade
        self.title      = title
        self.summary    = about
        self.imageName  = img_name
    }
    
    func getStringGrade() -> String{
        return "\(grade!)"
    }
}
