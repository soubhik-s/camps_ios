//
//  GestureVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 15/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class GestureVC: UIViewController {

    @IBOutlet weak var IMGVIew: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
   override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {
        IMGVIew.layer.cornerRadius = 10
        IMGVIew.layer.masksToBounds = true
        if GestureVariables.Title != "" {
            IMGVIew.image = GestureVariables.IMG.toImage()
            titleLbl.text = GestureVariables.Title
            descriptionLbl.text = GestureVariables.Description
        }
        
        
       
    }
   
    
    
    @IBAction func backAxn(_ sender: UIButton) {
        
       let VC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.pushViewController(VC, animated: true)


    }
    
    
    
    

}
