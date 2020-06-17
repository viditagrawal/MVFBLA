//
//  FBLAEventsVC.swift
//  FblaSignUpPage
//
//  Created by sid on 2/18/20.
//  Copyright © 2020 sid. All rights reserved.
//

import UIKit
import FirebaseDatabase
class FBLAEventsVC: UIViewController {

    @IBOutlet weak var EventTV: UITableView!
    var myEvents: [FBLAEvents] = []
    var selectedIndex: Int?
    static var selectedEvent_global: FBLAEvents?
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var dataView_titleLabel: UILabel!
    @IBOutlet weak var dataView_description: UILabel!
    @IBOutlet weak var dataView_dateLabel: UILabel!
    @IBOutlet weak var seeMembersButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var membersView: UIView!
    @IBOutlet weak var memebersTextView: UITextView!
    
    var signUp = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        dataView.alpha = 0.0
        self.EventTV.delegate = self
        self.EventTV.dataSource = self
        
        copyData()
        for event in constantVal.allEvents{
            event.printEvent()
        }
        
        if(signUp){
           signUpButton.setTitle("Sign Up", for: .normal)
       } else{
           signUpButton.setTitle("Drop Event", for: .normal)
       }
    }
    
    
    func copyData(){
        myEvents = constantVal.allEvents
    }
    
    @IBAction func backButton(_ sender: Any) {
        UIView.animate(withDuration: 0.75, animations: {
            self.EventTV.alpha = 1.0
            self.dataView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.dataView.alpha = 0.0
        })
        
    }
    
    @IBAction func membersBackButton(_ sender: Any) {
        self.membersView.isHidden = true
        
    }
    func setDataView(event: FBLAEvents){
        dataView_titleLabel.text = event.title!
        dataView_description.text = event.description!
        dataView_dateLabel.text = event.date!
        
        if(event.numberOfMembers! == 0 || !constantVal.allUsers[constantVal.currentUID]!.isOfficer!){ seeMembersButton.isHidden = true }
        else{ seeMembersButton.isHidden = false}
    }
    
    @IBAction func goToList(_ sender: Any) {
        print("FINNA GO TO LISTTTTT")
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        var ref: DatabaseReference! = Database.database().reference()

        if(signUp){
            var dataDictionary: [String: Any] = [:]
            constantVal.allEvents[selectedIndex!].addMember(uid: constantVal.allUsers[constantVal.currentUID]!.uid!, name: constantVal.allUsers[constantVal.currentUID]!.name!)
            
            for (uid, name) in constantVal.allEvents[selectedIndex!].members!{
                dataDictionary[uid] = name
            }
            
            
            ref.child("Events").child(constantVal.allEvents[selectedIndex!].title!).child("members").updateChildValues(dataDictionary)
            signUp = !signUp
            
        } else {
            print(constantVal.allEvents[selectedIndex!].numberOfMembers)
            print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            print("we are in here!!!")

            var dataDictionary: [String: Any] = [:]
            
            constantVal.allEvents[selectedIndex!].removeMember(uid: constantVal.allUsers[constantVal.currentUID]!.uid!, name: constantVal.allUsers[constantVal.currentUID]!.name!)
            if(constantVal.allEvents[selectedIndex!].numberOfMembers! == 0){
                print("we are in here3")
                ref.child("Events").child(constantVal.allEvents[selectedIndex!].title!).child("members").removeValue()
            } else {
                print("we are in here 2")
                
                for (uid, name) in constantVal.allEvents[selectedIndex!].members!{
                    dataDictionary[uid] = name
                }
                print(dataDictionary)
                
                ref.child("Events").child(constantVal.allEvents[selectedIndex!].title!).child("members").setValue(dataDictionary)
            }
            signUp = !signUp
        }
        if(signUp){
            signUpButton.setTitle("Sign Up", for: .normal)
            
        } else{
            signUpButton.setTitle("Drop Event", for: .normal)
            
        }
    
        
    }
    
    @IBAction func showEventMembers(_ sender: Any) {
        self.membersView.isHidden = false
        let event = myEvents[selectedIndex!]
        var viewString = ""
        for (uid, name) in event.members!{
            viewString += "\(name)\n\(constantVal.allUsers[constantVal.currentUID]!.email!)\n\n"
        }
        memebersTextView.text = viewString
    }
    
    
}


extension FBLAEventsVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! FBLAEventCell
        cell.set(eventValue: myEvents[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setDataView(event: self.myEvents[indexPath.row])
        selectedIndex = indexPath.row
        FBLAEventsVC.selectedEvent_global = constantVal.allEvents[indexPath.row]
        signUp = !constantVal.allEvents[selectedIndex!].containsUser(with: constantVal.allUsers[constantVal.currentUID]!)
        
        if(signUp){
            signUpButton.setTitle("Sign Up", for: .normal)
        } else{
            signUpButton.setTitle("Drop Event", for: .normal)
        }
        
        UIView.animate(withDuration: 0.75, animations: {
            self.EventTV.alpha = 0.0
            self.dataView.transform = .identity
            self.dataView.alpha = 1.0
       })
    }

    
}
