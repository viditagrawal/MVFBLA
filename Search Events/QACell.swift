//
//  QACell.swift
//  FblaSignUpPage
//
//  Created by Sid on 1/2/20.
//  Copyright © 2020 sid. All rights reserved.
//

import UIKit

class QACell: UITableViewCell {

    @IBOutlet weak var backgroundAnswerView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    var currentState = false
    
    func set(data: QASet){
        answerLabel.text = data.getAnswer()
        questionLabel.text = data.getQuestion()
        backgroundAnswerView.layer.cornerRadius = 15
        questionView.layer.cornerRadius = 15
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))

               // 2. add the gesture recognizer to a view
        questionView.addGestureRecognizer(tapGesture)
        backgroundAnswerView.addGestureRecognizer(tapGesture)
    }

           // 3. this method is called when a tap is recognized
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if(!currentState){
            self.remove()
        } else{
            self.reset()
        }
        currentState = !currentState
   }
    
    func remove(){
        UIView.animate(withDuration: 1.0, animations: {
            self.questionView.alpha = 0.0
            self.questionView.transform = self.questionView.transform.concatenating(CGAffineTransform(translationX: self.questionView.frame.width, y: 0))
        })
        
    }
    
    func reset(){
        UIView.animate(withDuration: 1.0, animations: {
            self.questionView.alpha = 1.0
            self.questionView.transform = .identity
        })
    }
    
    
    
  
    
    
}
