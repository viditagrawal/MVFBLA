//
//  ButtonController.swift
//  FblaSignUpPage
//
//  Created by Ritvik on 3/2/20.
//  Copyright © 2020 sid. All rights reserved.
//

import Foundation

import UIKit

class ButtonController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.layer.cornerRadius = 15
    }


}

