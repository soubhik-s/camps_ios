//
//  PolicyVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 17/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class PolicyVC: UIViewController {

    @IBOutlet weak var agreement_View: UIView!
    
    @IBOutlet weak var terms_View: UIView!
    
    @IBOutlet weak var img_View: UIImageView!
    
    @IBOutlet weak var privacy_View: UIView!
    
 let url_Arr = ["https://camps.goexploreandaman.com/user-agreement","https://camps.goexploreandaman.com/terms-and-conditions","https://camps.goexploreandaman.com/privacy-policy"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {
        img_View.layer.cornerRadius = 10
        agreement_View.makeRound()
        terms_View.makeRound()
        privacy_View.makeRound()
    let agree_Tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    let terms_Tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    let privacy_Tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        agreement_View.addGestureRecognizer(agree_Tap)
        terms_View.addGestureRecognizer(terms_Tap)
        privacy_View.addGestureRecognizer(privacy_Tap)
    }
      
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        
        
            switch sender.view?.tag {
            case 0:
                guard let url = URL(string: "\(url_Arr[0])") else {
                     return
                 }
                if UIApplication.shared.canOpenURL(url) {
                     UIApplication.shared.open(url, options: [:], completionHandler: nil)
                 }
            case 1:

               guard let url = URL(string: "\(url_Arr[1])") else {
                     return
                 }
                if UIApplication.shared.canOpenURL(url) {
                     UIApplication.shared.open(url, options: [:], completionHandler: nil)
                 }
            case 2:
                guard let url = URL(string: "\(url_Arr[2])") else {
                     return
                 }
                if UIApplication.shared.canOpenURL(url) {
                     UIApplication.shared.open(url, options: [:], completionHandler: nil)
                 }
            default:
                break
            }
        
        
        }
    
    
    @IBAction func back_Axn(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }
    
    
    
    
    
}
