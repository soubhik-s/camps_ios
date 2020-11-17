//
//  BoardTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 15/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class BoardTVC: UITableViewCell {

    @IBOutlet weak var bookingID_Lbl: UILabel!
    
    @IBOutlet weak var activityBtn: UIButton!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var campLbl: UILabel!
    
    @IBOutlet weak var docStatus_Lbl: UILabel!
    @IBOutlet weak var pkgID_Lbl: UILabel!
    @IBOutlet weak var id_Lbl: UILabel!
    @IBOutlet weak var packageLbl: UILabel!
    
    @IBOutlet weak var payNow_Btn: UIButton!
    @IBOutlet weak var pStatus_Lbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
  
    @IBOutlet weak var pkgDetals_Btn: UIButton!
    
    @IBOutlet weak var doc_Lbl: UILabel!
    
    @IBOutlet weak var invoice_Btn: UIButton!
   
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        blurView.layer.cornerRadius = 10
        blurView.layer.masksToBounds = true 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func activites_Btn_Axn(_ sender: UIButton) {
    }
    
    
    @IBAction func payNow_Btn_Axn(_ sender: UIButton) {
    }
    
    
    @IBAction func invoice_Btn_Axn(_ sender: UIButton) {
    }
    
    @IBAction func userInfo_Btn_Axn(_ sender: UIButton) {
    }
    

    @IBAction func oofers_Btn_Axn(_ sender: UIButton) {
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OffersVC") as! OffersVC
        DashboardVariables.isDashboard = true 
        self.parentContainerViewController()?.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    
}
