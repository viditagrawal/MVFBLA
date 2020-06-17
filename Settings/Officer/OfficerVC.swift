//
//  ViewController.swift
//  FBLA-Officer-Page
//
//  Created by Sid on 11/23/19.
//  Copyright © 2019 Sid. All rights reserved.
//

import UIKit

class OfficerVC: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var GradeLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var AboutLabel: UILabel!
    @IBOutlet weak var officerImage: UIImageView!
    var officers: [Officer] = [Officer]()
    let gradesString = "09   10   11   12"
    let directorString = "Director of:\n"
    var currentNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createOfficers()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swiped(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swiped(sender:)))
        
        setViewData()
        
        rightSwipe.direction = .right
        leftSwipe.direction = .left
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        // Do any additional setup after loading the view.
    }
    
    
    func createOfficers(){
        let newOfficer1 = Officer(name: "Akshat R.", grade: 11, title: "Logisticsw", about: "I joined FBLA in my sophomore year, and the only thing I regret is not joining sooner. My favorite part of FBLA honestly has to be the amazing people I’ve met through it. Sure, the competition is exciting, and conferences are always a blast, but the group of colorful and unique individuals in FBLA is what makes it so much fun. In one year, I have made so many new friends and amazing memories that I will never forget!", img_name: "akshat")
        let newOfficer2 = Officer(name: "Arya J.", grade: 12, title: "Operations", about: "Hey Everyone! I'm Arya and I'm excited to be serving as your Director of Operations. I've had countless amazing experiences with FBLA, from standing on stage in front of 13,000 people to running a mile in the rain to get pizza. Competing has taught me so much about business, public speaking and stress management. Attending conferences and being part of the MVFBLA culture is a great break from school and is something I'll always look forward to.", img_name: "arya")
        let newOfficer3 = Officer(name: "Daniel D.", grade: 12, title: "Entrepreneurship", about: "Hey Everyone! I'm Ritvik and I'm excited to be serving as your Director of Individual Oral Competitions. I've had countless amazing experiences with FBLA, from standing on stage in front of 13,000 people to running a mile in the rain to get pizza. Competing has taught me so much about business, public speaking and stress management. Attending conferences and being part of the MVFBLA culture is a great break from school and is something I'll always look forward to.", img_name: "daniel")
        officers.append(newOfficer1)
        officers.append(newOfficer2)
        officers.append(newOfficer3)
    }
    
    @objc func swiped(sender: UISwipeGestureRecognizer){
        print("in here")
        if sender.state == .ended{
            switch sender.direction{
            case .right:
                if(currentNumber > 0){
                    self.NameLabel.text     = ""

                    currentNumber = currentNumber - 1
                    setViewData()

                }
            case .left:
                if(currentNumber < officers.count-1){
                    self.NameLabel.text     = ""

                    currentNumber = currentNumber + 1
                    setViewData()

                }
            default:
                break
            }
        
        }
    }
    
    func setViewData(){
        
        let officer = officers[currentNumber]
        self.NameLabel.text     = ""
        self.GradeLabel.text    = ""
        self.TitleLabel.text    = ""
        self.AboutLabel.text    = ""
        
        self.NameLabel.animation(typing: officer.name!, duration: 0.4/Double(officer.name!.count))
        
        UIView.transition(with: self.officerImage,
                          duration:0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.officerImage.image = UIImage(named: officer.imageName!) },
                          completion: nil)
        
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: gradesString)
        attributedString.setColorForText(textForAttribute: officer.getStringGrade(), withColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
        self.GradeLabel.attributedText = attributedString
        
        let attributedString2: NSMutableAttributedString = NSMutableAttributedString(string: directorString + officer.title!)
        attributedString2.setColorForText(textForAttribute: officer.title!, withColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
        self.TitleLabel.attributedText = attributedString2
        
        self.AboutLabel.text = officer.summary!
        
    }
    
    


}

