//
//  ViewController.swift
//  Example
//
//  Created by SOTSYS027 on 02/05/18.
//  Copyright © 2018 SOTSYS027. All rights reserved.
//

import UIKit
import ADDatePicker

class DateController: UIViewController {

    public static var back: UIColor = {
          if #available(iOS 13, *) {
              return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                  if UITraitCollection.userInterfaceStyle == .dark {
                      /// Return the color for Dark Mode
                      return .black
                  } else {
                      /// Return the color for Light Mode
                      return .lightGray
                  }
              }
          } else {
              /// Return a fallback color for iOS 12 and lower.
              return .gray
          }
      }()
    
    public static var text: UIColor = {
             if #available(iOS 13, *) {
                 return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                     if UITraitCollection.userInterfaceStyle == .dark {
                         /// Return the color for Dark Mode
                         return .white
                     } else {
                         /// Return the color for Light Mode
                         return .black
                     }
                 }
             } else {
                 /// Return a fallback color for iOS 12 and lower.
                 return .gray
             }
         }()
    @IBOutlet weak var datePicker: ADDatePicker!

    @IBOutlet weak var btnGetDate: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        customDatePicker1()
        self.view.backgroundColor = DateController.back
        
        
    }
  
    
    func customDatePicker1(){
        datePicker.yearRange(inBetween: 1990, end: 2022)
        datePicker.selectionType = .circle
        
        if #available(iOS 13.0, *) {
            datePicker.bgColor = DateController.back
        } else {
            datePicker.bgColor = .darkGray
        }
        datePicker.deselectTextColor = UIColor.init(white: 1.0, alpha: 0.7)
        datePicker.deselectedBgColor = .clear
        datePicker.selectedBgColor = .white
        datePicker.selectedTextColor = .cyan
        datePicker.intialDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        // datePicker.delegate = self
        datePicker.selectionType = .circle
        btnGetDate.titleLabel?.textColor = DateController.text
    }
    
    @IBAction func getDate(_ sender: UIButton) {
        let date = datePicker.getSelectedDate()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM d, yyyy"
        btnGetDate.setTitle(dateformatter.string(from: date) , for: .normal)
    }
   
}

extension DateController: ADDatePickerDelegate {
       func ADDatePicker(didChange date: Date) {
           let dateformatter = DateFormatter()
           dateformatter.dateFormat = "MMM d, yyyy"
           btnGetDate.setTitle(dateformatter.string(from: date) , for: .normal)
       }
   }

