//
//  BookingInfoVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 15/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class BookingInfoVC: UIViewController {

    @IBOutlet weak var sib_Mobile_No: UILabel!
    
    @IBOutlet weak var sib_Gender_Lbl: UILabel!
    @IBOutlet weak var sib_email_Lbl: UILabel!
    @IBOutlet weak var sib_Name_Lbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var signLbl: UILabel!
    
    @IBOutlet weak var TShirtLbl: UILabel!
    @IBOutlet weak var campLbl: UILabel!
    @IBOutlet weak var DOBLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var batchLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var packageNameLbl: UILabel!
    
    @IBOutlet weak var citizenLbl: UILabel!
    @IBOutlet weak var langLbl: UILabel!
  
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var P_ContactLbl: UILabel!
    
    @IBOutlet weak var p_AddressLbl: UILabel!
    @IBOutlet weak var p_EmailLbl: UILabel!
    @IBOutlet weak var p_NameLbl: UILabel!
   
    @IBOutlet weak var T_DetailsLbl: UILabel!
    @IBOutlet weak var M_InfoLbl: UILabel!
    
    @IBOutlet weak var T_InfoLbl: UILabel!
    
    @IBOutlet weak var M_DetailsLbl: UILabel!
    
    
    @IBOutlet weak var callTimeLbl: UILabel!
    @IBOutlet weak var W_CallLbl: UILabel!
    @IBOutlet weak var contactNoLbl: UILabel!
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var callTypeLbl: UILabel!
    var dataArr:GetBookingResponse = []
    
    @IBOutlet weak var sibling_SV: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subView.isHidden = true
        getData()
    }
    

    @IBAction func back_Btn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getData()  {
                                
         if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
            
        ApiService.callPost(url: ClientInterface.bookingUrl, params: "", methodType: "GET", tag: "Dashboard", finish:finishPost)
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .actionSheet)
                    
        }
    }
        
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
            
            hideActivityIndicator()
            
            do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(GetBookingResponse.self, from: jsonData)
                print(parsedData)
            
               dataArr = parsedData
               print("BookingInfo = \(dataArr)")
              
               
                for bookingData in parsedData {
                    if bookingData.id == "\(DashboardVariables.selected_Id)" {
                        signLbl.text = bookingData.verify_doc_sign_status!
                        packageNameLbl.text = bookingData.package_name!
                        priceLbl.text = bookingData.price!
                        campLbl.text = bookingData.season_camp!
                        batchLbl.text = bookingData.camp_batch!
                        nameLbl.text = "\(bookingData.first_name!) " + bookingData.last_name!
                        DOBLbl.text = bookingData.dob!
                        genderLbl.text = bookingData.gender!
                        heightLbl.text = bookingData.height!
                        weightLbl.text = bookingData.weight!
                        TShirtLbl.text = bookingData.t_shirt_size!
                        langLbl.text = bookingData.mother_tonque!
                        citizenLbl.text = bookingData.citizenship!
                        addressLbl.text = "\(bookingData.address!) " + "\(bookingData.city!) " + "\(bookingData.state!) " + "\(bookingData.country!)"
                        p_NameLbl.text = "\(bookingData.p_first_name!) " + bookingData.p_last_name!
                        P_ContactLbl.text = bookingData.p_mobile_number!
                        p_EmailLbl.text = bookingData.p_email!

                        p_AddressLbl.text = "\(bookingData.p_address!) " + "\(bookingData.p_city!) " + "\(bookingData.p_state!) " + "\(bookingData.p_country!)"
                        M_InfoLbl.text = bookingData.medical_info!
                        M_DetailsLbl.text = bookingData.medical_details!
                        T_InfoLbl.text = bookingData.treatments!
                        T_DetailsLbl.text = bookingData.treatment_details!
                        callTypeLbl.text = bookingData.video_call!
                        contactNoLbl.text = bookingData.video_call_link!
                        W_CallLbl.text = bookingData.weekend_call!
                        callTimeLbl.text = bookingData.weekend_time_for_call!
                  
                        sib_Name_Lbl.text = bookingData.siblings_first_name ?? "" + bookingData.siblings_last_name!
                        sib_email_Lbl.text = bookingData.siblings_email
                        sib_Gender_Lbl.text = bookingData.siblings_gender
                        sib_Mobile_No.text = bookingData.siblings_gender
                         
                        if   bookingData.siblings_info?.isEmpty == false {
                            
                            sibling_SV.isHidden = false
                        }
                        
                        
                    } else {
                        print("Other_ID")
                    }
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5,
                            initialSpringVelocity: 0.5, options: [], animations:
                            {
                self.subView.isHidden = false

                self.subView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
                    
                  
                
                }
                } else {
                getData()
            }
            } catch {
            popUpAlert(title: "Alert", message: "Failed to send Password. Try Again. ", action: .alert)
            print("Parse Error: \(error)")
            }
            
        }
}
