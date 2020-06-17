//
//  ColorForLabel_Extension.swift
//  FBLA-Officer-Page
//
//  Created by Sid on 11/23/19.
//  Copyright © 2019 Sid. All rights reserved.
//

import Foundation
import UIKit
extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)

        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

}


extension UILabel{

  func animation(typing value:String,duration: Double){
    let characters = value.map { $0 }
    var index = 0
    Timer.scheduledTimer(withTimeInterval: duration, repeats: true, block: { [weak self] timer in
        if index < value.count {
            let char = characters[index]
            self?.text! += "\(char)"
            index += 1
        } else {
            timer.invalidate()
        }
    })
  }


  func textWithAnimation(text:String,duration:CFTimeInterval){
    fadeTransition(duration)
    self.text = text
  }

  //followed from @Chris and @winnie-ru
  func fadeTransition(_ duration:CFTimeInterval) {
    let animation = CATransition()
    animation.timingFunction = CAMediaTimingFunction(name:
        CAMediaTimingFunctionName.easeInEaseOut)
    animation.type = CATransitionType.fade
    animation.duration = duration
    layer.add(animation, forKey: CATransitionType.fade.rawValue)
  }

}
