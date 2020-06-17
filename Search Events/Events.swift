//
//  Events.swift
//  FblaSignUpPage
//
//  Created by Sid on 1/4/20.
//  Copyright © 2020 sid. All rights reserved.
//

import Foundation

class Events{
    var title: String?
    var date: String?
    var summary: String?
    
    init(title: String, date: String, summary: String) {
        var value = title
        value.removeLast()
        value.removeLast()
        value.removeLast()
        value.removeLast()
        value.removeLast()
        self.title = title
        self.date = date
        self.summary = summary
    }
    
    func getTitle()     -> String{ return title!    }
    func getDate()      -> String{ return date!     }
    func getSummary()   -> String{ return summary!  }
}
