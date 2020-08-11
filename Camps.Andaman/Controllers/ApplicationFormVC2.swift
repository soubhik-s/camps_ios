//
//  ApplicationFormVC2.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 11/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class ApplicationFormVC2: UIViewController {
    
    @IBOutlet weak var agegroup_Lbl: UILabel!
    @IBOutlet weak var packageNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var healthIssueTF: UITextField!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var treatementTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    
    @IBOutlet weak var countryTF: UITextField!
    
    @IBOutlet weak var pincodeTF: UITextField!
    
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    
    @IBOutlet weak var healthIssueSC: UISegmentedControl!
    
    
    @IBOutlet weak var treatementSC: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    func viewChanges() {
        headerView.layer.cornerRadius = 10
        nextBtn.makeRound()
       
       packageNameLbl.text = BookingDetails.package_name
       priceLbl.text = BookingDetails.price
       agegroup_Lbl.text = BookingDetails.age_Group
        
    }

    
    @IBAction func backAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func nextBtnAxn(_ sender: UIButton) {
        
        if streetTF.text == "" || countryTF.text == "" || stateTF.text == "" || stateTF.text == "" || cityTF.text == "" || pincodeTF.text == "" {
        popUpAlert(title: "Alert", message: "Enter All Detials", action: .alert)
        } else {
        BookingDetails.street = streetTF.text!
        BookingDetails.country = countryTF.text!
        BookingDetails.state = stateTF.text!
        BookingDetails.city = cityTF.text!
        BookingDetails.pincode = pincodeTF.text!
        
        if healthIssueSC.selectedSegmentIndex == 0 {
        BookingDetails.medical_details = healthIssueTF.text!
        } else {
        BookingDetails.medical_details = "NA"
        }
        
        if treatementSC.selectedSegmentIndex == 0 {
        BookingDetails.treatments_details = treatementTF.text!
        } else {
        BookingDetails.treatments_details = "NA"
        }
         
            
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ApplicationFormVC3") as! ApplicationFormVC3
        self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    
    @IBAction func healthSCAxn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
        healthIssueTF.isHidden = false
        } else {
        healthIssueTF.isHidden = true
        }
    }
    
    
    
    @IBAction func treatementScAxn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
        treatementTF.isHidden = false
        } else {
        treatementTF.isHidden = true
        }
    }
    
    @IBAction func complicationSC_Axn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
        BookingDetails.medical_info = "Yes"
        healthIssueTF.isHidden = false
        } else {
        BookingDetails.medical_info = "NO"
        healthIssueTF.isHidden = true
        }
    }
    
    
    @IBAction func treatmentSC_Axn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
        BookingDetails.treatments = "YES"
        treatementTF.isHidden = false
        } else {
        BookingDetails.treatments = "NO"
        treatementTF.isHidden = true
        }
    }
    
    
}
