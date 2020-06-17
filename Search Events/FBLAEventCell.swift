//
//  FBLAEventCell.swift
//  FblaSignUpPage
//
//  Created by Sid on 2/19/20.
//  Copyright © 2020 sid. All rights reserved.
//


import UIKit
class FBLAEventCell: UITableViewCell {

    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    
    
    func set(eventValue: FBLAEvents){
        eventTitleLabel.text = eventValue.title!
        eventDateLabel.text = eventValue.date!
    }
    
   
    

}

