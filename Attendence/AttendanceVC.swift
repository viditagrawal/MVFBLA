//
//  AttendanceVC.swift
//  FblaSignUpPage
//
//  Created by Sid on 2/20/20.
//  Copyright © 2020 sid. All rights reserved.
//

import UIKit
import FirebaseCore
import Firebase
import Foundation
class AttendanceVC: UIViewController {
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var qrCodeIV: UIImageView!
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
                                 
                               } else {
                                   self.scanButton.isHidden = true
                                   
                               }
                    }
        
                    print("\(constantVal.currentUID) : \(constantVal.allUsers[constantVal.currentUID]!.name!)")
        let image = generateQRCode(from: "\(constantVal.currentUID) : \(constantVal.allUsers[constantVal.currentUID]!.name!)")
            self.qrCodeIV.image = image!
        // Do any additional setup after loading the view.
    }
        
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
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
}
