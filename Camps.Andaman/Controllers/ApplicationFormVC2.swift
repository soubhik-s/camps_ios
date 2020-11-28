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
    @IBOutlet weak var company_Address_TF: UITextField!
    @IBOutlet weak var companyName_TF: UITextField!
    @IBOutlet weak var GST_Number_TF: UITextField!
    @IBOutlet weak var profile_ImgView: UIImageView!
    @IBOutlet weak var back_Img_View: UIImageView!
    @IBOutlet weak var ID_Card_Number: UITextField!
    @IBOutlet weak var front_Img_View: UIImageView!
    var pickedImg = UIImage()
    var selectedTap = 0
  
    @IBOutlet weak var P_Back_IMGView: UIImageView!
    
    @IBOutlet weak var parents_ID_TF: UITextField!
    @IBOutlet weak var P_Front_Img_View: UIImageView!
    
    
    
    @IBOutlet var parent_Details_view: UIView!
    
    let P_Height:CGFloat = 300
    
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
        
        let image_Tap_1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let image_Tap_2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let image_Tap_3 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
         
        profile_ImgView.addGestureRecognizer(image_Tap_1)
        front_Img_View.addGestureRecognizer(image_Tap_2)
        back_Img_View.addGestureRecognizer(image_Tap_3)
        if BookingDetails.age_Group == "adult" {
            
        }
    }
                  
    
   
       
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        selectedTap = sender.view?.tag ?? 0
        openGallery()
    }
    // image picker functions

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])        {
   let pickedImage = (info[.editedImage] as! UIImage)

    if selectedTap == 1 {
        front_Img_View.image = pickedImage
    } else if selectedTap == 2 {
        back_Img_View.image = pickedImage

    } else {
        profile_ImgView.image = pickedImage
    }
   
    print("Image is picked")
        
    picker.dismiss(animated: true) {
        print("Image Saved")
     
    }
        
}
    
    
    @IBAction func closeBtn_Axn(_ sender: UIButton) {
        hideTopView(View: parent_Details_view, height: P_Height)
    }
    
    

    @IBAction func uploadParents_Btn(_ sender: UIButton) {
        showViewFromTop(View: parent_Details_view, height: P_Height)
        
    }
    
    @IBAction func backAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func nextBtnAxn(_ sender: UIButton) {
        
        if streetTF.text == "" || countryTF.text == "" || stateTF.text == "" || stateTF.text == "" || cityTF.text == "" || pincodeTF.text == "" {
        popUpAlert(title: "Alert", message: "Enter All Details", action: .alert)
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
    
    
    
    @IBAction func GST_SC_Axn(_ sender: UISegmentedControl) {
        if sender.tag == 1{
            GST_Number_TF.isHidden = true
            companyName_TF.isHidden =  true
            company_Address_TF.isHidden = true
        } else {
            GST_Number_TF.isHidden = false
            companyName_TF.isHidden =  false
            company_Address_TF.isHidden = false
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
