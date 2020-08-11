//
//  TextFiled+Ext.swift
//  One for Patient
//
//  Created by Idontknow on 21/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import Foundation
import UIKit





extension UITextField {
    
   func pastDatePicker() {
    let datePickerView = UIDatePicker()
    datePickerView.datePickerMode = .date
    datePickerView.maximumDate = Date()
    self.inputView = datePickerView
    datePickerView.backgroundColor = UIColor.white
    datePickerView.setValue(UIColor.black, forKey: "textColor")
    datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    func futureDatePicker() {
    let datePickerView = UIDatePicker()
    datePickerView.datePickerMode = .date
    datePickerView.minimumDate = Date()
    self.inputView = datePickerView
    datePickerView.backgroundColor = UIColor.white
    datePickerView.setValue(UIColor.black, forKey: "textColor")
    datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    func timePicker() {
    let datePickerView = UIDatePicker()
    datePickerView.datePickerMode = .time
    datePickerView.backgroundColor = UIColor.white
    datePickerView.setValue(UIColor.black, forKey: "textColor")
    datePickerView.addTarget(self, action: #selector(handleTimePicker(sender:)), for: .valueChanged)

    }

    @objc func handleDatePicker(sender: UIDatePicker) {
    let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        self.text = dateFormatter.string(from: sender.date)


    }
    
    @objc func handleTimePicker(sender: UIDatePicker) {
    let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.timeStyle = .short
        self.text = dateFormatter.string(from: sender.date)

    }

        
        
    enum Direction {
        case Left
        case Right
    }
func withImage(direction: Direction, image: UIImage){
    let mainView = UIView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        mainView.layer.cornerRadius = 5
        
    let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 5, y: 5, width: 15, height: 15)
        mainView.addSubview(imageView)
        mainView.layer.cornerRadius = 5
        
        if(Direction.Left == direction)
        { // image left
            self.leftViewMode = .always
            self.leftView = mainView
        }
        else
        { // image right
            self.rightViewMode = .always
            self.rightView = mainView
        }
    }
func textFieldIcons(textfield:UITextField, imageName:String, direction:Direction) {
    let myImage = UIImage(named: imageName)
        textfield.withImage(direction:direction , image: myImage!)
        
    }
    enum Visibility {
        case visible
        case invisible
        case gone
    }
    
    var visibility: Visibility {
        get {
            let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
            if let constraint = constraint, constraint.isActive {
                return .gone
            } else {
                return self.isHidden ? .invisible : .visible
            }
        }
        set {
            if self.visibility != newValue {
                self.setVisibility(newValue)
            }
        }
    }
    
    private func setVisibility(_ visibility: Visibility) {
        let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
        
        switch visibility {
        case .visible:
            constraint?.isActive = false
            self.isHidden = false
            break
        case .invisible:
            constraint?.isActive = false
            self.isHidden = true
            break
        case .gone:
            if let constraint = constraint {
                constraint.isActive = true
            } else {
                let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
                self.addConstraint(constraint)
                constraint.isActive = true
            }
        }
    }
    
    func pulse() {
           
           let pulse = CASpringAnimation(keyPath: "transform.scale")
           pulse.duration = 0.2
           pulse.fromValue = 0.95
           pulse.toValue = 1.0
           pulse.autoreverses = true
           pulse.repeatCount = 2
           pulse.initialVelocity = 0.5
           pulse.damping = 1.0
           
           layer.add(pulse, forKey: "pulse")
       }
       
       func flash() {
           
           let flash = CABasicAnimation(keyPath: "opacity")
           flash.duration = 0.2
           flash.fromValue = 1
           flash.toValue = 0.1
           flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
           flash.autoreverses = true
           flash.repeatCount = 3
           
           layer.add(flash, forKey: nil)
       }
       
       
       func shake() {
           
           let shake = CABasicAnimation(keyPath: "position")
           shake.duration = 0.07
           shake.repeatCount = 3
           shake.autoreverses = true
           
           let fromPoint = CGPoint(x: center.x - 5, y: center.y)
           let fromValue = NSValue(cgPoint: fromPoint)
           
           let toPoint = CGPoint(x: center.x + 5, y: center.y)
           let toValue = NSValue(cgPoint: toPoint)
           
           shake.fromValue = fromValue
           shake.toValue = toValue
           
           layer.add(shake, forKey: "position")
       }
    
    
    func makeRound() {
        
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
    }
    
    
    func placeHolderColor() {
    self.attributedPlaceholder = NSAttributedString(string: "placeholder text",
    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
}


