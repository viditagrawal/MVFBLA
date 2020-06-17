//
//  HomePageVC.swift
//  FblaSignUpPage
//
//  Created by Sid on 1/29/20.
//  Copyright © 2020 sid. All rights reserved.
//

import UIKit
import FirebaseDatabase
class HomePageVC: UIViewController {

    @IBOutlet weak var attendanceButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromDB{ (success) in
            if(success){
                print("------------------a-")
                print(constantVal.allUsers.count)
                for (key,value) in constantVal.allUsers{
                    value.printValue()
                    print("--------------------")
                }
                if(constantVal.allUsers[constantVal.currentUID]!.isOfficer!){
                    self.scanButton.isHidden = false
                           self.attendanceButton.isHidden = true
                       } else {
                           self.scanButton.isHidden = true
                           self.attendanceButton.isHidden = false
                       }
            }
        }
        // Do any additional setup after loading the view.
       
    }
    
    
    @IBAction func OpenFBLAWebsite(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "http://www.mvfbla.org")! as URL)
    }
    @IBAction func accessSocialMedia(_ sender: UIButton) {
        let tag = sender.tag
        switch tag {
        case 0:
            //show some animation here
            break
        case 1:
            UIApplication.shared.openURL(NSURL(string: "https://www.facebook.com/MontaVistaBusiness/")! as URL)
            break
        case 2:
            UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/mvfbla/?hl=en")! as URL)
            break
        default:
            break
        }

    }
    
    func readFromDB(success:@escaping (Bool) -> Void){
        let ref = Database.database().reference()
        ref.child("Members").observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                let values = Array(data.values)
                
               print(values)
                
                let valueDict  = values as! [[String: Any]]
                for objects in valueDict{
                    let name = objects["name"] as! String
                    let email = objects["email"] as! String
                    let officerStatus = objects["isOfficer"] as! Bool
                    let UID = objects["user Id"] as! String
                    let SID = objects["studentId"] as! Int
                    let gradYear = objects["grad Year"] as! Int
                    let Userattend = objects["attendance"] as! Int
                    

                    let curUser = Users.init(name: name, email: email, isOfficer: officerStatus, sID: "\(SID)", uid: UID, gradYear: gradYear, attendance: Userattend )
                    constantVal.allUsers[UID] = curUser
                    print("in here")
                    
                }
                print("WE ARE IN HERE")
               success(true)

            }
        }) { (error) in  print(error.localizedDescription) }
        
        ref.child("Events").observeSingleEvent(of: .value, with: { (snapshot) in
            constantVal.allEvents.removeAll()
            if let data = snapshot.value as? [String: Any] {
                let values = Array(data.values)
                let name = Array(data.keys)
                print(name)
                print("THIS IS THE NAME!!!!!!!!")
                
                // print(data)
                let valueDict  = values as! [[String: Any]]
                var intValue = 0
                for object in valueDict{
                    let date = object["Date"] as! String
                    let description = object["Summary"] as! String
                   
                    var newEvent = FBLAEvents(date: date, description: description, title: name[intValue])
                    let member = object["members"] as? [String: String]
                    if(member != nil){
                        for (key, value) in member!{
                            print(key)
                            print(value)
                            newEvent.addMember(uid: key, name: value)

                        }
                    }
                    intValue += 1
                    constantVal.allEvents.append(newEvent)
                }
                success(true)
            }
        }) { (error) in  print(error.localizedDescription) }
//        ref.child("Events").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let data = snapshot.value as? [String: Any] {
//                let values = Array(data.values)
//                constantVal.allEvents.removeAll()
//                print(values)
//
//                let valueDict  = values as! [[String: Any]]
//                for objects in valueDict{
//                    let title = objects["title"] as? String
//                    let start = objects["start"] as? String
//                    let end = objects["end"] as? String
//                    let lat = objects["latitude"] as? CLLocationDegrees
//                    let long = objects["longitude"] as? CLLocationDegrees
//                    let summary = objects["summary"] as? String
//                    let max = objects["max sign ups"] as? Int
//                    let currentSU = objects["current sign ups"] as? Int
//                    let eID = objects["eventID"] as! String
//                    let hours = objects["hours"] as? Int
//
//                    let preString = "signUp"
////                    print(title!)
////                    print(start!)
////                    print(end!)
////                    print(location!)
////                    print(summary!)
////                    print(currentSU!)
////                    print(currentWL!)
////                    print(max!)
//
//                    let eLocation = CLLocation(latitude: lat!, longitude: long!)
//
//                    var a = Events.init(name: title!, start: start!, end: end!, length: end!, limit: max!, eventLocation: eLocation, eventSummary: summary!, uid: eID, hours: hours!)
//                    for n in 0..<currentSU!{
//                        print("signUp\(n)")
//                        var string = "signUp\(n)"
//                        var code = objects[string] as! String
//                        let use = constantVal.allUsers[code]
//                        string = "checkIn\(n)"
//                        code = objects[string] as! String
//                        a.addNewSignUp(participantName: use!, CIStatus: code)
//                        //let userCode: String = (objects["signUp\(n)"] as? String)!
//                        //let user: Users = constantVal.allUsers[userCode]!
//                        //a.addNewSignUp(participantName: user)
//                    }
//
////                    for n in 0..<currentWL!{
////                        let string = "signUp\(n)"
////                        let code = objects[string] as! String
////                        let use = constantVal.allUsers[code]
////                        a.addNewSignUp(participantName: use!)
////                    }
//
//
//                    a.toString()
//                    constantVal.allEvents.append(a)
//                    constantVal.allEvents = constantVal.allEvents.sorted { $0.eventName < $1.eventName }
//
//                }
//                success(true)
//            }
//        }) { (error) in  print(error.localizedDescription) }
//        if(userAble){
//            success(true)
//        }
    }
    @IBAction func showQA(_ sender: Any) {
           let newvc = self.storyboard?.instantiateViewController(withIdentifier: "qaView") as! UIViewController
           
           newvc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
           
           self.present(newvc, animated: true, completion: nil)
       }
       @IBAction func showFblaCompetitions(_ sender: Any) {
         let newvc = self.storyboard?.instantiateViewController(withIdentifier: "competitionsView") as! UIViewController
         
         newvc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
         
         self.present(newvc, animated: true, completion: nil)
           
       }
       @IBAction func contactUs(_ sender: Any) {
           let newvc = self.storyboard?.instantiateViewController(withIdentifier: "contactView") as! UIViewController
           
           newvc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
           
           self.present(newvc, animated: true, completion: nil)
           
       }
   
    @IBAction func showEventsPage(_ sender: Any) {
        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "fblaEventView") as! UIViewController
        
        newvc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        
        self.present(newvc, animated: true, completion: nil)
        
    }
    
    @IBAction func showAttendance(_ sender: Any) {
        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "attendanceView") as! UIViewController
        
        newvc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        
        self.present(newvc, animated: true, completion: nil)
    }
    
    
    @IBAction func showScanner(_ sender: Any) {
        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "scannerView") as! UIViewController
        
        newvc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        
        self.present(newvc, animated: true, completion: nil)
    }
    
    @IBAction func showOfficers(_ sender: Any) {
        let newvc = self.storyboard?.instantiateViewController(withIdentifier: "officerView") as! UIViewController
              
              newvc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
              
              self.present(newvc, animated: true, completion: nil)
        
    }
    
    
}
