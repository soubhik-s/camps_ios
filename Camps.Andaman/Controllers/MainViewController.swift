//
//  MainViewController.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 05/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewLead: NSLayoutConstraint!
    
    @IBOutlet weak var sideMenuLead: NSLayoutConstraint!
    
    @IBOutlet weak var sideMenuView: UIView!
    
    
    var menuVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        panGestureFunc()
    }
    @IBAction func menuAxn(_ sender: UIButton) {
        toggleSideMenu(fromViewController: self)
    }
    

    func panGestureFunc() {
    
        let panGestureRecognizser = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)) )
           view.addGestureRecognizer(panGestureRecognizser)
           self.navigationController?.isNavigationBarHidden = true
           sideMenuLead.constant = 0 - UIScreen.main.bounds.width
    }
           
            
        
    //   /  Handling SideMenu by PanGesture
               
        @objc func toggleSideMenu(fromViewController: UIViewController) {
            print("sidemenu")
            if(menuVisible){
            UIView.animate(withDuration: 0.5, animations: {
            self.sideMenuLead.constant = 0 - self.sideMenuView.frame.size.width
                    self.contentViewLead.constant = 0
                    self.view.layoutIfNeeded()
                       })
                   } else {
                    self.view.layoutIfNeeded()
                    UIView.animate(withDuration: 0.5, animations: {
                           // move the side menu to the right to show it
                    self.sideMenuLead.constant = 0
                           // move the content view (tab bar controller) to the right
                    self.contentViewLead.constant = self.sideMenuView.frame.size.width
                    self.view.layoutIfNeeded()
                self.sideMenuView.elevate(elevation: 5.0)
        //            self.contentView.addBlurEffect()
                       })
                   }
                   
                   menuVisible = !menuVisible
        }

               // function to handle the pan gesture
              
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer){

        let translation = recognizer.translation(in: self.view)
                print("panned x: \(translation.x), y: \(translation.y)")
                // when user lift up finger / end drag
            if(recognizer.state == .ended || recognizer.state == .failed || recognizer.state == .cancelled){
                if(menuVisible){
                       // user finger moved to left before ending drag
                    if(translation.x < 0){
                         // toggle side menu (to fully hide it)
                    toggleSideMenu(fromViewController: self)
                    }
                    } else {
                       // user finger moved to right and more than 100pt
                    if(translation.x > 100.0){
                         // toggle side menu (to fully show it)
                    toggleSideMenu(fromViewController: self)
                    } else {
                    // user finger moved to right but too less
                    // hide back the side menu (with animation)
                    view.layoutIfNeeded()
                    UIView.animate(withDuration: 0.5, animations: {
                    self.sideMenuLead.constant = 0 - self.sideMenuView.frame.size.width
                    self.contentViewLead.constant = 0
                    self.view.layoutIfNeeded()
                    })
                    }
                    }
                     return
                }
                         
        
    }
            
}
