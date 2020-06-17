//
//  EventCell.swift
//  FblaSignUpPage
//
//  Created by Sid on 12/31/19.
//  Copyright © 2019 sid. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var subcategoryLabel: UILabel!
    
    func set(color: UIColor, eventName: String, subcategory: String) {
        backgroundColorView.layer.cornerRadius = 20
        self.backgroundColorView.backgroundColor = color
        self.eventNameLabel.text = eventName
        self.subcategoryLabel.text = subcategory
    }

}
