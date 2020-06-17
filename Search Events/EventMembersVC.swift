//
//  EventMembersVC.swift
//  FblaSignUpPage
//
//  Created by Sid on 2/23/20.
//  Copyright © 2020 sid. All rights reserved.
//

import UIKit

class EventMembersVC: UIViewController{
    
    
    var members: [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        members = [String]()
        let event = FBLAEventsVC.selectedEvent_global!
        for (uid, name) in event.members!{
            members!.append(name)
        }
        print(members)
        
        

        // Do any additional setup after loading the view.
    }
    



}



