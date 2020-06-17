//
//  ContactUs.swift
//  FblaSignUpPage
//
//  Created by Sid on 2/4/20.
//  Copyright © 2020 sid. All rights reserved.
//

import UIKit
import MessageUI
class ContactUs: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var messageTF: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendMessage(_ sender: Any) {
        let name = nameTF.text!
        let email = emailTF.text!
        let message = messageTF.text!
        sendEmail(name: name, email: email, message: message)
    }
    
    
    func sendEmail(name: String, email: String, message: String) {
      if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients([email])
        mail.setSubject(name)
        mail.setMessageBody("Hello FBLA Officers, \n<p>\(message)</p>\n --\nThanks,\n\(constantVal.allUsers[constantVal.currentUID]!.name!) ", isHTML: true)
//TAKE THE USERS NAME FROM THE DATABASE HERE BEFORE YOU SUBMIT THE MAIL
        present(mail, animated: true)
      } else {
        print("THIS DOESN'T WORK")
      }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    @IBAction func allOfficersButton(_ sender: Any) {
        emailTF.text = "info@montavistafbla.org"
    }
    
   
    
}


