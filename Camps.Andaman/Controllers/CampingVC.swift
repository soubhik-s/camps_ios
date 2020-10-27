//
//  CampingVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 20/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//


//Mark : Activities Details
import UIKit

class CampingVC: UIViewController {
    
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var headerIMGView: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    @IBOutlet weak var title_Lbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewChanges()
        

    }
    
    func viewChanges() {
        headerIMGView.layer.cornerRadius = 10
       
        headerIMGView.setImage(urlStr: ClientConfig.Activity_ImgUrl + ActivityVariables.locIMG)
        title_Lbl.text = ActivityVariables.locTitle
        descriptionLbl.text = ActivityVariables.locDescription

    }
    
    
    @IBAction func back_Axn(_ sender: UIButton) {
       
        self.navigationController?.popViewController(animated: true)

       
    }
    
    
    

}


       
    
   

    
    
    

