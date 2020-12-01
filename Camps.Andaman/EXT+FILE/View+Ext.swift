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
        
    func makeRound() {
            self.layer.cornerRadius = self.frame.height/2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.1

    }
    
    func constrainToBounds(of view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSLayoutConstraint.Attribute] = [.leading, .top, .trailing, .bottom]
        let constraints = attrs.map { (attr) -> NSLayoutConstraint in
        return NSLayoutConstraint(item: self,
                                          attribute: attr,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: attr,
                                          multiplier: 1.0,
                                          constant: 0)
            }
            
        NSLayoutConstraint.activate(constraints)
    }
    
    func showActivityIndicator() {
            
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            activityIndicator.backgroundColor = .clear
            activityIndicator.layer.cornerRadius = 6
            activityIndicator.center = self.center
            activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
            activityIndicator.color = .white
            activityIndicator.tag = 111
            self.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }

        func hideActivityIndicator() {
            let activityIndicator = self.viewWithTag(111) as? UIActivityIndicatorView
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()
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

extension UICollectionView {
    @objc func scrollToNextCell(){

        //get cell size
        let cellSize = self.frame.size

        //get current content Offset of the Collection view
        let contentOffset = self.contentOffset

        if self.contentSize.width <= self.contentOffset.x + cellSize.width
        {
            let r = CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
            self.scrollRectToVisible(r, animated: true)

        } else {
            let r = CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
            self.scrollRectToVisible(r, animated: true);
        }

    }
    
//    func scrollToNextCell(){
//
//        //get Collection View Instance
//        let collectionView:UICollectionView;
//
//        //get cell size
//        let cellSize = self.frame.size
//
//        //get current content Offset of the Collection view
//        let contentOffset = collectionView.contentOffset
//
//        //scroll to next cell
//        collectionView.scrollRectToVisible(CGRectMake(contentOffset.x + cellSize.width, contentOffset.y, cellSize.width, cellSize.height), animated: true)
//
//
//    }

    /**
     Invokes Timer to start Automatic Animation with repeat enabled
     */
    func autoScroll() {

        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil, repeats: true);


    }
    
}
    
    
   
extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
        return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
        
            return getTopViewController(base: selected)

       } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
            
        }
        return base
        
    }
    
}
    
    
    
    
    
    

    
    
    

