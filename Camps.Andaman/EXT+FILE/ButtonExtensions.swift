//
//  ButtonExtensions.swift
//  SmartBottleFeeding
//
//  Created by Anita on 5/18/1398 AP.
//  Copyright © 1398 Annanta. All rights reserved.
//
import UIKit
import Foundation


extension UIButton {
    
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
    
    func underlineMyText(text:String, color:UIColor) {
       
        if let textString = self.titleLabel?.text {
         let str = NSString(string: textString)
         let txt = str.range(of: text)
         let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: txt)
         attributedString.addAttribute(NSAttributedString.Key.underlineColor, value:color, range: txt)
         self.setAttributedTitle(attributedString, for: .normal)
        
        }
    }
    
    func makeBtnRound() {
        self.layer.cornerRadius = self.frame.height/2
//        self.layer.masksToBounds = true
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
//uiLabel.textWithAnimation(text: "text you want to replace", duration: 0.2)


      
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
      
    func underlineMyText(text:String, color:UIColor) {
        if let textString = self.text {
        let str = NSString(string: textString)
        let txt = str.range(of: text)
        let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: txt)
            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value:color, range: txt)
            attributedText = attributedString
       }
    }
    
   var optimalHeight : CGFloat {
        get
        {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
        
    }
       
}

extension UISegmentedControl {
    
   func makeRounded() {
        
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
}
