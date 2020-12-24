//
//  SelfDetailsVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 03/07/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class SelfDetailsVC: UIViewController {

    @IBOutlet weak var twt_Btn: UIButton!
    @IBOutlet weak var fb_Btn: UIButton!
    @IBOutlet weak var SV_TC: NSLayoutConstraint!
    
    @IBOutlet weak var social_SV: UIStackView!
    @IBOutlet weak var linkd_Btn: UIButton!
    @IBOutlet weak var Img_View: UIImageView!
    
    @IBOutlet weak var details_Lbl: UILabel!
    
    @IBOutlet weak var designation_Lbl: UILabel!
    @IBOutlet weak var name_Lbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkInternet()

        ViewChanges()
        
    }
    

    func ViewChanges() {
//        buttonOne()
        Img_View.makeRounded()
        Img_View.image = PersonDetails.img.toImage()
        name_Lbl.text = PersonDetails.name
        details_Lbl.text = PersonDetails.description
        designation_Lbl.text = PersonDetails.designation
    }

    
    @IBAction func back_Axn(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
    
   
    
    @IBAction func btns_Axn(_ sender: UIButton) {
        
        switch sender.tag {
       
        case 0:
          
            print("FaceBook")
            
            if PersonDetails.links[0] == "" {
                popUpAlert(title: "Alert", message: "Unable to open ", action: .alert)
                print("Unable to open the link")
            
            } else {
               guard let urlStr = URL(string: "\(PersonDetails.links[0])") else {
                    return
                
                   }
            if UIApplication.shared.canOpenURL(urlStr) {
                 UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
                 print("urlStr = \(urlStr)")
            } else {
                popUpAlert(title: "Alert", message: "Unable to open the link", action: .alert)
                print("Unable")

                }
            }
            
        
        case 1:
       
            print("Twiltter")
            if PersonDetails.links[1] == "" {
                popUpAlert(title: "Alert", message: "Unable to open ", action: .alert)
                print("Unable to open the link")
            
            } else {
               guard let urlStr = URL(string: "\(PersonDetails.links[1])") else {
                    return
                
                   }
                if UIApplication.shared.canOpenURL(urlStr) {
                 UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
                print("urlStr = \(urlStr)")
                    
                } else {
                popUpAlert(title: "Alert", message: "Unable to open the link", action: .alert)
                    print("Unable")

                }
            }
        case 2:
            
        if PersonDetails.links[2] == "" {
            popUpAlert(title: "Alert", message: "Unable to open ", action: .alert)
            print("Unable to open the link")
        
        } else {
           guard let urlStr = URL(string: "\(PersonDetails.links[2])") else {
                return
            
               }
            if UIApplication.shared.canOpenURL(urlStr) {
             UIApplication.shared.open(urlStr, options: [:], completionHandler: nil)
            print("urlStr = \(urlStr)")
                
            } else {
            popUpAlert(title: "Alert", message: "Unable to open the link", action: .alert)
                
           print("Unable")
            }
        }
        default:
            print("No")
        }
    }
    
    func buttonOne() {
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {

         }, completion: {_ in
            self.linkd_Btn.shake()

            self.buttonTwo()
           })
        
    }
    
    func buttonTwo() {
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
            
        }, completion: {_ in
            self.twt_Btn.pulse()

        self.buttonThree()
          
        })
        
    }
    
    func buttonThree() {
       
       UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {

        }, completion: {_ in
       
            self.fb_Btn.flash()

            self.buttonOne()
          })

       
    }
    
}
