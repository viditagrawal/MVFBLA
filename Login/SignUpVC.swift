//
//  ViewController.swift
//  FblaSignUpPage
//
//  Created by sid on 12/21/19.
//  Copyright © 2019 sid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class SignUpVC: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!              //label that prompts the user for their name
    @IBOutlet weak var emailLabel: UILabel!             //label that prompts the user for their email
    @IBOutlet weak var DoneLabel: UILabel!              //label that ends the sign up process
    @IBOutlet weak var studentIDLabel: UILabel!         //label that prompts the user for their student identification
    @IBOutlet weak var codeLabel: UILabel!              //label that prompts the user to enter the chapter specific code
    
    @IBOutlet weak var inputField: UITextField!         //the initial text field that takes all singular input
    @IBOutlet weak var secondaryInputField: UITextField!//in the case that a secondary input is required this text field will be used

    @IBOutlet weak var nextButton: UIButton!            //initiates the transition from one screen to the next
    @IBOutlet weak var seniorButton: UIButton!          //button with text "2020" indicates that the new user is in the 12th grade
    @IBOutlet weak var JuniorButton: UIButton!          //button with text "2021" indicates that the new user is in the 11th grade
    @IBOutlet weak var SophButton: UIButton!            //button with text "2022" indicates that the new user is in the 10th grade
    @IBOutlet weak var FreshmanButton: UIButton!        //button with text "2023" indicates that the new user is in the 9th grade
    @IBOutlet weak var termsOfUseButton: UIButton!      //button hows the terms of use for the application
    @IBOutlet weak var cancelButton: UIButton!          //if the user does not want to sign up, they can press this button to abort the cancellation process
    @IBOutlet weak var TOUView: UIView!                 //shows the terms of use
    
    static let storedData = UserDefaults.standard       //data that is stored on the device
    
    //Constants
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let animationBuffer: CGFloat = 30.0                 //pixel amount buffer for animations to ensure they run smoothly
    let animationTiming = 0.75                          //length of animation in seconds
    //Current Form Condition
    var currentState: Int = 0
    
    //Data Collection
    var nameData:           String?
    var emailData:          String?
    var passwordData:       String?
    var studentID_Data:     Int?
    var gradYear:           Int?
    var code_Data:          Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    //Adds transformations for all of the views to put them in their initial positions before the user starts the form
    func setUp(){
        
        var transforms4 = CGAffineTransform.identity
        nextButton.layer.cornerRadius = 15
        secondaryInputField.alpha = 0.0

        transforms4 = transforms4.translatedBy(x: screenWidth+animationBuffer, y: 0)
        
        emailLabel.transform = transforms4
        studentIDLabel.transform = transforms4
        DoneLabel.transform = transforms4
        codeLabel.transform = transforms4
        
        transforms4 = CGAffineTransform.identity
        transforms4 = transforms4.translatedBy(x: 0, y: animationBuffer/2)
        
        seniorButton.alpha = 0.0
        seniorButton.transform = transforms4
        
        JuniorButton.alpha = 0.0
        JuniorButton.transform = transforms4

        SophButton.alpha = 0.0
        SophButton.transform = transforms4

        FreshmanButton.alpha = 0.0
        FreshmanButton.transform = transforms4
        
        termsOfUseButton.contentHorizontalAlignment = .center
        termsOfUseButton.alpha = 0.0
        cancelButton.alpha = 0.0
        
        transforms4 = CGAffineTransform.identity
        transforms4 = transforms4.scaledBy(x: 0.00001, y: 0.00001)
        TOUView.transform = transforms4
        TOUView.layer.cornerRadius  = 40


    }
    
    //Upon the user clicking the next button, this function will initiate the transitions as well as collect the data from the form
    @IBAction func nextScreen(_ sender: Any){
        
        if(currentState == 0){
            //Getting the data from the input field
            let name = self.inputField.text!
            if(name.count == 0){
                showErrorAnimation()
                return
            }
            self.nameData = name
            //If the data is sufficient, we are going to change the state
            currentState = 1
            
            //Setting the data for the next label
            self.emailLabel.text = "Hello \(self.inputField.text!), let's create your account, please enter an email and password"
            //Setting the placeholder for the textfield and removing the text that is currently there
            self.inputField.placeholder = "Email"
            self.inputField.text = ""
            
            UIView.animate(withDuration: animationTiming, animations: {
                //Shifting the labels so the new label is where the old one was
                var transforms = CGAffineTransform.identity
                transforms = transforms.translatedBy(x: -(self.screenWidth+self.animationBuffer), y: 0)
                self.nameLabel.transform = transforms
                self.emailLabel.transform = CGAffineTransform.identity
                
                //Introduces the password field and moves the next button down
                transforms = CGAffineTransform.identity
                transforms = transforms.translatedBy(x: 0, y: self.inputField.bounds.height + self.animationBuffer)
                self.secondaryInputField.transform = transforms
                self.secondaryInputField.alpha = 1.0
                self.nextButton.transform = transforms
                
            })

        } else if(currentState == 1){
            //Getting the data from the input field
            let email = self.inputField.text!
            let password = self.secondaryInputField.text!
            if(!email.contains("@") || password.count == 0 || !email.contains(".")){
                showErrorAnimation()
                return
            }
            
            self.emailData     = email
            self.passwordData  = password
            //If the data is sufficient, we are going to change the state
            currentState = 2
            //This will set the data for the new views that will come onto the screen
            self.studentIDLabel.text = "Wonderful, now that you have created you account, we will need a little more information to make sure you are eligible to join."
            self.inputField.placeholder = "Student ID"
            self.inputField.text = ""
            secondaryInputField.resignFirstResponder()

            //animates the change
            UIView.animate(withDuration: animationTiming, animations: {
                //Shifts the labels
                var transforms = CGAffineTransform.identity
                transforms = transforms.translatedBy(x: -(self.screenWidth+self.animationBuffer), y: 0)
                self.emailLabel.transform = transforms
                self.studentIDLabel.transform = CGAffineTransform.identity
                //Introduces the password field and moes the next button down too
                self.secondaryInputField.transform = self.secondaryInputField.transform.concatenating(CGAffineTransform(translationX: self.screenWidth+self.animationBuffer, y: 0))
                self.nextButton.transform = self.nextButton.transform.concatenating(CGAffineTransform(translationX: 0, y:                 -self.inputField.bounds.height + self.animationBuffer/2))
            })
            UIView.animate(withDuration: animationTiming, animations: {
                self.seniorButton.alpha = 1.0
                self.seniorButton.transform = .identity
            })
            UIView.animate(withDuration: animationTiming, delay: animationTiming/4, options: .curveLinear, animations: {
                self.JuniorButton.alpha = 1.0
                self.JuniorButton.transform = .identity
            }, completion: nil)
            UIView.animate(withDuration: animationTiming, delay: animationTiming/2, options: .curveLinear, animations: {
                self.SophButton.alpha = 1.0
                self.SophButton.transform = .identity
            }, completion: nil)
            UIView.animate(withDuration: animationTiming, delay: 3*animationTiming/4, options: .curveLinear, animations: {
                self.FreshmanButton.alpha = 1.0
                self.FreshmanButton.transform = .identity
            }, completion: nil)
        } else if(currentState == 2) {
            let studentId = self.inputField.text!
            if(studentId.count != 7){
                showErrorAnimation()
                return
            }
            self.studentID_Data = Int(studentId)!
            currentState = 3
            
            codeLabel.text = "Last one, we promise. Please enter the chapter code given to you by your FBLA officers."
            self.inputField.placeholder = "Chapter Code"
            self.inputField.text = ""

            UIView.animate(withDuration: animationTiming, animations: {
                self.nextButton.transform = self.nextButton.transform.concatenating(CGAffineTransform(translationX: 0, y: -(self.seniorButton.bounds.height*2)))
                self.codeLabel.transform = .identity
                var transforms = CGAffineTransform.identity
                               transforms = transforms.translatedBy(x: -(self.screenWidth+self.animationBuffer), y: 0)
                self.studentIDLabel.transform = transforms
            })
            
            UIView.animate(withDuration: animationTiming/2, animations: {
                self.seniorButton.alpha = 0
                self.seniorButton.transform = CGAffineTransform.identity.translatedBy(x: 0, y: self.animationBuffer/2)
            })
            UIView.animate(withDuration: animationTiming/2, delay: animationTiming/4, options: .curveLinear, animations: {
                self.JuniorButton.alpha = 0
                self.JuniorButton.transform = CGAffineTransform.identity.translatedBy(x: 0, y: self.animationBuffer/2)
            }, completion: nil)
            UIView.animate(withDuration: animationTiming/2, delay: animationTiming/2, options: .curveLinear, animations: {
                self.SophButton.alpha = 0
                self.SophButton.transform = CGAffineTransform.identity.translatedBy(x: 0, y: self.animationBuffer/2)
            }, completion: nil)
            UIView.animate(withDuration: animationTiming/2, delay: 3*animationTiming/4, options: .curveLinear, animations: {
                self.FreshmanButton.alpha = 0
                self.FreshmanButton.transform = CGAffineTransform.identity.translatedBy(x: 0, y: self.animationBuffer/2)
            }, completion: nil)
            
        } else if(currentState == 3) {
            let code = self.inputField.text!
            if(code.count != 4 || Int(code) != 9190){
                showErrorAnimation()
                return
            }
            currentState = 4
            self.code_Data = Int(code)!
            self.nextButton.setTitle("Done", for: .normal)
            
            DoneLabel.text = "Thank you very much for signing up for MVFBLA, we are incredibly excited to have a wonderful year with you!"
            
            UIView.animate(withDuration: animationTiming, animations: {
                self.DoneLabel.transform = .identity
                var transforms = CGAffineTransform.identity
                               transforms = transforms.translatedBy(x: -(self.screenWidth+self.animationBuffer), y: 0)
                self.codeLabel.transform = transforms
                self.inputField.transform = transforms
                self.nextButton.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -(self.inputField.bounds.height+self.animationBuffer))
                self.cancelButton.alpha = 1.0
                self.termsOfUseButton.alpha = 1.0
            })
            
            
        } else {
            showData{ (success) in
                if(success){
                    SignUpVC.storedData.set(true, forKey: "Got Intro")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    //If the data inputted into the form is not valid, this method will animate the button to show an error
    func showErrorAnimation(){
        UIView.animate(withDuration: self.animationTiming/5, animations: {
            self.nextButton.transform = self.nextButton.transform.concatenating(CGAffineTransform(translationX: 15, y: 0))
        })
        
        UIView.animate(withDuration: self.animationTiming/5, delay: self.animationTiming/5, options: .curveEaseIn, animations: {
            self.nextButton.transform = self.nextButton.transform.concatenating(CGAffineTransform(translationX: -30, y: 0))

        }, completion: nil)
        
        UIView.animate(withDuration: self.animationTiming/5, delay: self.animationTiming/2.5, options: .curveEaseIn, animations: {
            self.nextButton.transform = self.nextButton.transform.concatenating(CGAffineTransform(translationX: 15, y: 0))

        }, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
    @IBAction func yearButton(_ sender: UIButton) {
        //Setting the default color of everything when any button is pressed
        seniorButton.backgroundColor    = UIColor(named: "Color2")
        JuniorButton.backgroundColor    = UIColor(named: "Color2")
        SophButton.backgroundColor      = UIColor(named: "Color2")
        FreshmanButton.backgroundColor  = UIColor(named: "Color2")
        //Changing the color of a specific button based on which one is pressed
        switch sender.tag{
        case 0: seniorButton.backgroundColor    = UIColor(named: "Color3"); self.gradYear = 2020
        case 1: JuniorButton.backgroundColor    = UIColor(named: "Color3"); self.gradYear = 2021
        case 2: SophButton.backgroundColor      = UIColor(named: "Color3"); self.gradYear = 2022
        case 3: FreshmanButton.backgroundColor  = UIColor(named: "Color3"); self.gradYear = 2023
        default: return
        }
        
    }
    
    //Takes the data the user put into the form and put it into the database
    func showData(success:@escaping (Bool) -> Void){
        Auth.auth().createUser(withEmail: self.emailData!, password: MD5(self.passwordData!)) { (user, error) in
            if(error != nil){
                print(error)
                success(false)
                return
            }
        
            var ref: DatabaseReference!     = Database.database().reference()
            
            var dataDictionary:             [String: Any] = [:]
            dataDictionary["name"]          = self.nameData!
            dataDictionary["email"]         = self.emailData!
            dataDictionary["studentId"]     = self.studentID_Data!
            dataDictionary["user Id"]       = (user?.user.uid)!
            dataDictionary["grad Year"]     = self.gradYear!
            dataDictionary["hours"]         = 0
            dataDictionary["isOfficer"]     = false
            dataDictionary["attendance"]    = 0
            ref.child("Members").child((user?.user.uid)!).setValue(dataDictionary)
            success(true)
        }
        
       

    }
    
    //Dismisses the current view controller if the cancel button is pressed
    @IBAction func cancelButtonPressed(_ sender: Any) {
        print("we are in here")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Shows the Terms of Use button
    @IBAction func showTermsOfUse(_ sender: Any) {
        self.TOUView.isHidden = false
        UIView.animate(withDuration: animationTiming, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                   self.TOUView.transform = .identity
        }, completion: nil)
    }
    @IBAction func cancelButton(_ sender: Any) {
        var transforms4 = CGAffineTransform.identity
        transforms4 = transforms4.scaledBy(x: 0, y: 0)
        TOUView.transform = transforms4
        self.TOUView.isHidden = true
    }
    
    
}

