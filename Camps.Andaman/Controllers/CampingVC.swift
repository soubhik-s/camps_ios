//
//  CampingVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 20/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class CampingVC: UIViewController {
    
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var activitiesLbl: UILabel!
    
    @IBOutlet weak var headerIMGView: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    @IBOutlet weak var title_Lbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewChanges()
        

    }
    
    func viewChanges() {
        headerIMGView.layer.cornerRadius = 10
       
        headerIMGView.layer.masksToBounds = true
        
        if LocationVariables.locTitle != "" {
        
            title_Lbl.text = LocationVariables.locTitle
            headerIMGView.image = LocationVariables.locIMG.toImage()
            descriptionLbl.text = LocationVariables.locDescription
            activitiesLbl.text = LocationVariables.locActitvity
        }
        

    }
    
    
    @IBAction func back_Axn(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
       
        self.navigationController?.popViewController(animated: true)
//     self.navigationController?.pushViewController(VC, animated: true)

       
    }
    
    
    

}


       
    
   

    
    
    

