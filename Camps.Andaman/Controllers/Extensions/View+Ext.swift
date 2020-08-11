//
//  View+Ext.swift
//  SmartBottleFeeding
//
//  Created by AnnantaSource on 8/14/1398 AP.
//  Copyright © 1398 Annanta. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
        
       
    // Add BlurEffect to view
    func addBlurEffect()  {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
    self.addSubview(blurEffectView)
    }
        
        /// Remove UIBlurEffect from UIView
    func removeBlurEffect() {
    let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
    blurredEffectViews.forEach{ blurView in
    blurView.removeFromSuperview()
    }
    }
        
   func shake(duration: CFTimeInterval) {
    let shakeValues = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
    

    let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
    translation.timingFunction = CAMediaTimingFunction(name: .linear)
    translation.values = shakeValues
            
    let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    rotation.values = shakeValues.map { (Int(Double.pi) * $0) / 180 }
            
    let shakeGroup = CAAnimationGroup()
    shakeGroup.animations = [translation, rotation]
    shakeGroup.duration = 1.0
    layer.add(shakeGroup, forKey: "shakeIt")
    }
        
        
}
    
    
extension UITableView {
    //  TableView reloading with animation
        func reloadWithAnimation() {
            self.reloadData()
            let tableViewHeight = self.bounds.size.height
            let cells = self.visibleCells
            var delayCounter = 0
            for cell in cells {
                cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            }
            for cell in cells {
                UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    cell.transform = CGAffineTransform.identity
                }, completion: nil)
                delayCounter += 1
            }
        }
    
    func fadeVisibleCells() {

        var delayCounter = 0.0

        for cell in self.visibleCells {

            cell.alpha = 0.0

            UIView.animate(withDuration: TimeInterval(delayCounter)) {
                cell.alpha = 1.0
            }

            delayCounter += 0.30
        }
    }
}
    
    
    
    
    
    
    
    
    

    
    
    

