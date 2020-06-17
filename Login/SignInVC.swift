//
//  SignInVC.swift
//  FblaSignUpPage
//
//  Created by Sid on 12/24/19.
//  Copyright © 2019 sid. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class SignInVC: UIViewController {
   
    @IBOutlet weak var emailField:      UITextField!
    @IBOutlet weak var passwordField:   UITextField!
    @IBOutlet weak var loginButton:     UIButton!
    @IBOutlet weak var signInLabel:     UILabel!
    @IBOutlet weak var signUpButton:    UIButton!
    @IBOutlet weak var outsideView:     UIView!
    @IBOutlet weak var insideView:      UIView!
    @IBOutlet weak var welcomeLabel:    UILabel!
    @IBOutlet weak var toFBLALabel:     UILabel!
    @IBOutlet weak var swipeUpLabel:    UILabel!
    
    let screenWidth     = UIScreen.main.bounds.width
    let screenHeight    = UIScreen.main.bounds.height
    let animationBuffer: CGFloat = 30.0
    let animationTiming = 1.0
    var uEmail: String?
    var uPswd:  String?
    var numberFail = 0
    var changePassword = false
    var differenceValue: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let hash1 = MD5("hello123")
        let hash2 = MD5("helloSid")
        
        for char in hash1{
            print("\(char)  ", terminator: "")
        }
        print()
        for char in hash1{
            let s = String(char).unicodeScalars
            print("\(s[s.startIndex].value) ", terminator:"")
            
        }
        print()
        for char in hash2{
            print("\(char)  ", terminator:"")
        }
        print()

        for char in hash2{
            let s = String(char).unicodeScalars
            print("\(s[s.startIndex].value) ", terminator:"")
            
        }
        print()
        let string = encodeChangePassword(oldPassword: hash1, newPassword: hash2)
        decodeChangePassword(password: hash2, decoderString: string)
        
        setUp()
        //Delays the method call by 2 seconds
        var value = SignUpVC.storedData.bool(forKey: "Got Intro")
        print(value)
        print("`````````````````````````")
        if let v = value as? Bool{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if(!v)  { self.showFirstAnimation() }
                else    { self.showSignIn()         }
            }

        }
    }
    
    func setUp(){
        
        var swipeUp =  UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipeUp))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        outsideView.layer.cornerRadius  = 40
        insideView.layer.cornerRadius   = 20
        loginButton.layer.cornerRadius  = 10
        swipeUpLabel.layer.cornerRadius = 30
        var transforms4 = CGAffineTransform.identity
        transforms4 = transforms4.translatedBy(x: -screenWidth, y: 0)
        welcomeLabel.transform = transforms4
        transforms4 = CGAffineTransform.identity
        transforms4 = transforms4.translatedBy(x: screenWidth, y: 0)
        toFBLALabel.transform = transforms4
        outsideView.transform = CGAffineTransform(scaleX: 0, y: 0)
        insideView.transform = CGAffineTransform(scaleX: 0, y: 0)
        swipeUpLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        //Hiding Everything so that when the user will swipe up it will all be visible
        signUpButton.transform = CGAffineTransform(scaleX: 0.75, y:0.750)
        signUpButton.alpha = 0.0
        loginButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        loginButton.alpha = 0.0
        signInLabel.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        signInLabel.alpha = 0.0
        passwordField.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        passwordField.alpha = 0.0
        emailField.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        emailField.alpha = 0.0

    
              
    }
    
    func showFirstAnimation(){
        print("WE ARE IN HEREEEEE")
        UIView.animate(withDuration: animationTiming, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.outsideView.transform = .identity
        }, completion: nil)
        UIView.animate(withDuration: animationTiming, delay: animationTiming, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.insideView.transform = .identity
        }, completion: nil)
       
        UIView.animate(withDuration: animationTiming, delay: animationTiming*2, options: .curveEaseInOut, animations: {
            self.welcomeLabel.transform = self.welcomeLabel.transform.concatenating(CGAffineTransform(translationX: 4*self.screenWidth/5, y: 0))
            self.toFBLALabel.transform = self.toFBLALabel.transform.concatenating(CGAffineTransform(translationX: -4*self.screenWidth/5, y: 0))
        }, completion: nil)

        UIView.animate(withDuration: animationTiming*3, delay: (animationTiming*2)-0.1, options: .curveEaseInOut, animations: {
            self.welcomeLabel.transform = self.welcomeLabel.transform.concatenating(CGAffineTransform(translationX: 2*self.screenWidth/5, y: 0))
            self.toFBLALabel.transform = self.toFBLALabel.transform.concatenating(CGAffineTransform(translationX: -2*self.screenWidth/5, y: 0))

        }, completion: nil)
        UIView.animate(withDuration: animationTiming, delay: (animationTiming*4)-0.1, options: .curveEaseInOut, animations: {
            self.welcomeLabel.transform = self.welcomeLabel.transform.concatenating(CGAffineTransform(translationX: self.screenWidth, y: 0))
            self.toFBLALabel.transform = self.toFBLALabel.transform.concatenating(CGAffineTransform(translationX: -self.screenWidth, y: 0))
        }, completion: nil)
        UIView.animate(withDuration: animationTiming, delay: (animationTiming*5.2), usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: .curveEaseInOut, animations: {
            self.swipeUpLabel.transform = .identity
        }, completion: nil)
        UIView.animate(withDuration: animationTiming, delay: (animationTiming*6), options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
            self.swipeUpLabel.transform = CGAffineTransform(translationX: 0, y: -5)
        }, completion: nil)

    }
    
   
    
    @objc func didSwipeUp() {
        if(!changePassword){
            UIView.animate(withDuration: animationTiming/2, delay: 0, options: .curveLinear, animations: {
                self.swipeUpLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
            }, completion: nil)
            UIView.animate(withDuration: animationTiming, delay: animationTiming/1.5, options: .curveEaseInOut, animations: {
                self.insideView.transform = CGAffineTransform(translationX: 0, y: -self.screenHeight)
            }, completion: nil)
            UIView.animate(withDuration: animationTiming, delay: animationTiming/1.2, options: .curveEaseInOut, animations: {
                self.outsideView.transform = CGAffineTransform(translationX: 0, y: -self.screenHeight)
            }, completion: nil)
            
            SignUpVC.storedData.set(true, forKey: "Got Intro")
            
            showSignIn()
            self.changePassword = true
        } else {
           
            
        }
    }
    
    
    
    func showSignIn(){
        //Show everything
        outsideView.isHidden = true
        insideView.isHidden = true
        
       UIView.animate(withDuration: animationTiming, delay: animationTiming/1.5+0.1, options: .curveEaseInOut, animations: {
           self.signUpButton.transform = .identity
           self.signUpButton.alpha = 1.0

       }, completion: nil)
       UIView.animate(withDuration: animationTiming, delay: animationTiming/1.5+0.2, options: .curveEaseInOut, animations: {
           self.loginButton.transform = .identity
           self.loginButton.alpha = 1.0

       }, completion: nil)
       UIView.animate(withDuration: animationTiming, delay: animationTiming/1.5+0.3, options: .curveEaseInOut, animations: {
           self.passwordField.transform = .identity
           self.passwordField.alpha = 1.0

       }, completion: nil)
       UIView.animate(withDuration: animationTiming, delay: animationTiming/1.5+0.4, options: .curveEaseInOut, animations: {
           self.emailField.transform = .identity
           self.emailField.alpha = 1.0

       }, completion: nil)
       UIView.animate(withDuration: animationTiming, delay: animationTiming/1.5+0.5, options: .curveEaseInOut, animations: {
           self.signInLabel.transform = .identity
           self.signInLabel.alpha = 1.0
       }, completion: nil)
        
        
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "signUp") as! UIViewController
        
        newvc.modalPresentationStyle = .automatic //or .overFullScreen for transparency
        /*** changed to .automatic in order to provide the user with the option to swipe down to exit*/
        
        self.present(newvc, animated: true, completion: nil)
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        
        let email = self.emailField.text!
        if(email.count == 0 || !email.contains("@") || !email.contains(".")){
            showErrorAnimation()
            return
        }
        self.uEmail = email
        let password = self.passwordField.text!
        if(password.count == 0 || password.count < 6){
            showErrorAnimation()
            return
        }
        self.uPswd = MD5(password)
        print("~~~~~~~~~~~~~~~~~~~~")
        print(self.uPswd!)
        print("~~~~~~~~~~~~~~~~~~~~")
        
        getDifferenceFromDB{ (success) in
            if(success){
                let finalPassword = self.decodeChangePassword(password: self.uPswd!, decoderString: self.differenceValue!)
                self.uPswd = finalPassword
                print("FINALLLL PASSWORDDD \(finalPassword)")
                
                
                self.logInUser{ (success) in
                    if(success){
                        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "tab_bar") as! UIViewController
                               
                               newvc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                               
                               self.present(newvc, animated: true, completion: nil)
                    } else {
                        self.showErrorAnimation()
                        self.numberFail += 1
                        if(self.numberFail == 2){
                            Auth.auth().sendPasswordReset(withEmail: email) { error in
                                print("ERRORRRRRR")
                                print(error)
                            }
                        }
                    }
                }
                
            }
        }
        
        
    }
    
    func logInUser(success:@escaping (Bool) -> Void){
        Auth.auth().signIn(withEmail: self.uEmail!, password: self.uPswd!) { (user, error) in
            if(error != nil){
                print(error)
                success(false)
                return
            } else {
                constantVal.currentUID = (user?.user.uid)!
                success(true)
            }
        }
    }
    
    func showErrorAnimation(){
           UIView.animate(withDuration: self.animationTiming/5, animations: {
               self.loginButton.transform = self.loginButton.transform.concatenating(CGAffineTransform(translationX: 15, y: 0))
           })
           
           UIView.animate(withDuration: self.animationTiming/5, delay: self.animationTiming/5, options: .curveEaseIn, animations: {
               self.loginButton.transform = self.loginButton.transform.concatenating(CGAffineTransform(translationX: -30, y: 0))

           }, completion: nil)
           
           UIView.animate(withDuration: self.animationTiming/5, delay: self.animationTiming/2.5, options: .curveEaseIn, animations: {
               self.loginButton.transform = self.loginButton.transform.concatenating(CGAffineTransform(translationX: 15, y: 0))

           }, completion: nil)
       }
       

    
    func encodeChangePassword(oldPassword: String, newPassword: String) -> String{
        
        let hashArray1 = Array(oldPassword)
        let hashArray2 = Array(newPassword)
        var differenceArray = [Int]()
        var returnString = ""
        for i in 0..<hashArray1.count{
            let s1 = hashArray1[i].unicodeScalars
            let s2 = hashArray2[i].unicodeScalars
            
            differenceArray.append(Int(s1[s1.startIndex].value) - Int(s2[s2.startIndex].value))
        }
        
        

        print(differenceArray)
        for value in differenceArray{
            returnString += "\(value),"
        }
        returnString.removeLast()
        print(returnString)
        return returnString
        
    }
    
    func decodeChangePassword(password: String, decoderString: String) -> String{
        
        var returnString = ""
        
        let array = decoderString.components(separatedBy: ",")
        
        print(array)
        let intArray = array.map { Int($0)!}
        print(intArray)
        

        let hashArray = Array(password)
        var calculatedHash = [Int]()
        
        for i in 0..<hashArray.count{
            let s1 = hashArray[i].unicodeScalars
            
            calculatedHash.append(Int(s1[s1.startIndex].value) + intArray[i])
        }
        for number in calculatedHash{
            returnString += "\(UnicodeScalar(number)!)"
        }
        
        print(returnString)
        
        return returnString
        
    }
    
    func getDifferenceFromDB(success:@escaping (Bool) -> Void){
        var returnString = ""
        let ref = Database.database().reference()
        ref.child("PswdDiffs").child(strip(email: self.emailField.text!)).observeSingleEvent(of: .value, with: {(snapshot) in
            if let data = snapshot.value as? [String: Any]{
                let values = Array(data.values)
                self.differenceValue = values[0] as! String
                success(true)
                
                
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        success(false)
    }
    
    func strip(email: String) -> String{
        var returnString = ""
        for char in email{
            if(char != "." && char != "@"){
                returnString += String(char)
            }
        }
        return returnString
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
              UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
          }
    
    
}
