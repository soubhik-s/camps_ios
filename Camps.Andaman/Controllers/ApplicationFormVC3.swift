//
//  ApplicationFormVC3.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 11/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class ApplicationFormVC3: UIViewController {

    @IBOutlet weak var hide_btn: UIButton!
    @IBOutlet weak var basePrice_Lbl: UILabel!
    @IBOutlet weak var package_Lbl: UILabel!
    
    @IBOutlet weak var totalPrice_Lbl: UILabel!
    @IBOutlet weak var dPrice_Lbl: UILabel!
    @IBOutlet weak var taxPrice_Lbl: UILabel!
    @IBOutlet var price_View: UIView!
    @IBOutlet weak var copoun_View: UIView!
    @IBOutlet weak var copoun_Img: UIImageView!
    @IBOutlet weak var age_Lbl: UILabel!
    @IBOutlet weak var price_Lbl: UILabel!
    @IBOutlet weak var header_View: UIView!
    
    @IBOutlet weak var submit_Btn: UIButton!
    
    @IBOutlet weak var p_LastNameTF: UITextField!
    @IBOutlet weak var p_FirstNameTF: UITextField!
    
    @IBOutlet weak var p_MobileTF: UITextField!
    
    @IBOutlet weak var code_TF: UITextField!
    
    @IBOutlet weak var alt_NumberTF: UITextField!
    
    
    @IBOutlet weak var apply_Btn: UIButton!
    @IBOutlet weak var P_EmailTF: UITextField!
    
    @IBOutlet weak var callType_TF: UITextField!
    
    @IBOutlet weak var callLink_TF: UITextField!
    
    @IBOutlet weak var call_SC: UISegmentedControl!
    
    @IBOutlet weak var callTime_TF: UITextField!

    @IBOutlet weak var address_SC: UISegmentedControl!
    
    @IBOutlet weak var address_SV: UIStackView!
    
    @IBOutlet weak var terms_Lbl: UILabel!
    
    @IBOutlet weak var p_street_TF: UITextField!
    
    @IBOutlet weak var p_Country_TF: UITextField!
    
    @IBOutlet weak var p_State_TF: UITextField!
    
    @IBOutlet weak var addInfo_TF: UITextField!
    
    @IBOutlet weak var p_pincode_TF: UITextField!
    
    @IBOutlet weak var p_City_TF: UITextField!
    @IBOutlet weak var agree_Btn: UIButton!
    
    var isChecked:Bool = true
    var picker = UIPickerView()
    let callType_Arr = ["Skype","WhatsApp","Messenger","Google Duo"]
    let callTime_Arr = ["Morning [9 AM - 12 PM]","Noon[12 PM - 5 PM]","Evening [5 PM - 7 PM]"]
    var parent_Address = "NO"
    var weekendCall = "YES"
    let termsUrl = "https://camps.goexploreandaman.com/terms-and-conditions"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        viewChanges()
    }
    

    func viewChanges() {
        copoun_View.layer.cornerRadius = 5
        
        header_View.layer.cornerRadius = 10
        submit_Btn.makeBtnRound()
        package_Lbl.text = BookingDetails.package_name
        price_Lbl.text = BookingDetails.price
        age_Lbl.text = BookingDetails.age_Group
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .lightColor
        let password_Tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            terms_Lbl.addGestureRecognizer(password_Tap)
        copoun_Img.isHidden = true
//       price View
        
        price_View.frame = CGRect(x: 10, y: 100, width: self.view.frame.width - 20, height: 250)
        
    }
    
    func showPriceView() {
        price_View.layer.cornerRadius = 10
        self.view.addBlurEffect()
        view.addSubview(price_View)
        
    }
    func hidePriceView() {
        self.view.removeBlurEffect()
        price_View.removeFromSuperview()
        
    }
    
      
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
         guard let url = URL(string: termsUrl) else {
                                return
        }
        if UIApplication.shared.canOpenURL(url) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           }
    }
        
    
    
    
    @IBAction func backAxn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func callMe_Axn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
        weekendCall = "NO"
        print("WeekendCall = \(weekendCall)")
        } else {
        weekendCall = "YES"
        print("WeekendCall = \(weekendCall)")
        }
    }
    
    @IBAction func addressSC_Axn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
        parent_Address = "NO"
        p_street_TF.text = ""
        p_Country_TF.text = ""
        p_State_TF.text = ""
        p_City_TF.text = ""
        p_pincode_TF.text = ""
        } else {
        parent_Address = "Yes"
        p_street_TF.text = BookingDetails.street
        p_Country_TF.text = BookingDetails.country
        p_State_TF.text = BookingDetails.state
        p_City_TF.text = BookingDetails.city
        p_pincode_TF.text = BookingDetails.pincode
        }
    }
    
    
    @IBAction func agreeBtn_Axn(_ sender: UIButton) {
        if isChecked == true {
        sender.setImage(UIImage(named: "black-check-box"), for: .normal)
        isChecked = false
        } else {
        sender.setImage(UIImage(named: "Check_W"), for: .normal)
        isChecked = true
        }
    }
    
    @IBAction func callType_Axn(_ sender: UITextField) {
        picker.reloadAllComponents()
        sender.inputView = picker
        
    }
    
    @IBAction func contactTime_Axn(_ sender: UITextField) {
        picker.reloadAllComponents()
        sender.inputView = picker
        
    }
    
    
    @IBAction func priceInfo_Axn(_ sender: UIButton) {
        showPriceView()
    }
    
    
    @IBAction func hidePrice_Axn(_ sender: UIButton) {
        hidePriceView()
    }
    
    @IBAction func submitBtn_Axn(_ sender: UIButton) {
       if p_FirstNameTF.text == "" || p_LastNameTF.text == "" || p_MobileTF.text == "" || alt_NumberTF.text == "" || P_EmailTF.text == "" || callType_TF.text == "" || callLink_TF.text == "" || callTime_TF.text == "" || p_street_TF.text == "" || p_Country_TF.text == "" || p_State_TF.text == "" || p_City_TF.text == "" || p_pincode_TF.text == "" {
        popUpAlert(title: "Alert", message: "Enter All Detials", action: .alert)
        } else if isChecked == false  {
        popUpAlert(title: "Alert", message: "Select Terms & Conditions", action: .alert)

       } else {
        postData()

        }
    }
    
    func postData()  {
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
          
            let details = ["ip_address":BookingDetails.ip_address, "user_id":BookingDetails.user_id, "package_id":BookingDetails.package_id, "package_name":BookingDetails.package_name, "price":price_Lbl.text! , "offer_price":dPrice_Lbl.text! ,"total_price":totalPrice_Lbl.text! , "quantity":"1", "seasonal_camp":BookingDetails.seasonal_camp, "camp_batch":BookingDetails.camp_batch, "first_name":BookingDetails.first_name, "middle_name":"", "last_name":BookingDetails.last_name, "dob":BookingDetails.DOB, "gender":BookingDetails.gender, "height":BookingDetails.height, "weight":BookingDetails.weight, "tshirt_size":BookingDetails.tshirt_size, "mother_tonque":BookingDetails.mother_tonque, "citizenship":BookingDetails.citizenship, "mobile_number":BookingDetails.mobile_number, "email":BookingDetails.email, "address":BookingDetails.street, "city":BookingDetails.city,  "country":BookingDetails.country, "pincode":BookingDetails.pincode, "medical_info":BookingDetails.medical_info, "medical_details":BookingDetails.medical_details, "treatments":BookingDetails.treatments, "treatments_details":BookingDetails.treatments_details, "p_first_name":p_FirstNameTF.text!, "p_middle_name":p_FirstNameTF.text!, "p_last_name":p_LastNameTF.text!, "p_mobile_number":p_MobileTF.text!, "p_alt_mobile_number":alt_NumberTF.text!, "p_email":P_EmailTF.text!, "video_call":callType_TF.text!, "video_call_link":callLink_TF.text!, "weekend_call":weekendCall, "time_for_call":callTime_TF.text!, "parent_address":parent_Address, "p_address":p_street_TF.text!, "p_city":p_City_TF.text!, "p_country":p_Country_TF.text!, "p_pincode":p_pincode_TF.text!, "additional_details":addInfo_TF.text!,  "coupon_code":code_TF.text! ] as [String:Any]
            
        ApiService.postCall(url: ClientInterface.bookingUrl, params: details, methodType: "POST", tag: "Booking", finish:finishPost)
         print("details = \(details)")
            
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection.", action: .alert)
        }
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
    
        hideActivityIndicator()
        if tag == "Offer" {
           
            do {
                if let jsonData = data {
                let parsedData = try JSONDecoder().decode(PostOfferResponse.self, from: jsonData)
                print(parsedData)
            
                if parsedData.statusCode == true {
                    copoun_Img.isHidden =  false
                    copoun_Img.image = UIImage(named: "tickG")
//                    code_TF.isHidden = true
//                    apply_Btn.isHidden = true
                    let onlyPrice = BookingDetails.price.fiterPrice()
                    print("onlyPrice = \(String(describing: onlyPrice))")
                   
//                    dPrice_Lbl.text = "\(parsedData.discount) %"
                    let discount_Amt = (Int(basePrice_Lbl.text!)! * Int(parsedData.discount)! ) / 100
                    print("discount_Amt = \(discount_Amt), \(dPrice_Lbl.text!)")
                    dPrice_Lbl.text = "\(discount_Amt)"
                    let finalPrice = Int(onlyPrice)! - discount_Amt
                    print("finalPrice = \(finalPrice)")
                    totalPrice_Lbl.text = "\(finalPrice)"
                    price_Lbl.text = "\(finalPrice)"
              
                    popUpAlert(title: parsedData.message, message: "", action: .alert)
              
                
                } else {
                    code_TF.shake()
                    copoun_Img.isHidden =  false
                    copoun_Img.image = UIImage(named: "cross2")
                    popUpAlert(title: "Alert", message: parsedData.message, action: .alert)
                    
                }
                } else {
                }
                } catch {
                popUpAlert(title: "Alert", message: "Error in Applying Copoun.Try Again. ", action: .alert)
                print("Parse Error: \(error)")
                }
            
        } else {

        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(BookingResponse.self, from: jsonData)
        print(parsedData)
    
        if parsedData.status == true {
        p_FirstNameTF.text = ""
        p_LastNameTF.text = ""
        p_MobileTF.text = ""
        alt_NumberTF.text = ""
        P_EmailTF.text = ""
        callType_TF.text = ""
        callLink_TF.text = ""
        callTime_TF.text = ""
        p_street_TF.text = ""
        p_Country_TF.text = ""
        p_State_TF.text = ""
        p_City_TF.text = ""
        p_pincode_TF.text = ""
        addInfo_TF.text = ""
            
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(VC, animated: true)
        
            alert(message: "Check Dashboard for details", title: "Application Submitted succesfully ")
//            popUpAlert(title: "Booking has done :). Our executive Contacts You ", message: " Check Dashboard for Bookings Details ", action: .alert)
        
        } else {
        popUpAlert(title: "Alert", message: "Error_Cheeck all  Details", action: .alert)
            
        }
        } else {
        postData()
        }
        } catch {
        popUpAlert(title: "Alert", message: "Booking Failed Check Details and Try Again. ", action: .alert)
        print("Parse Error: \(error)")
        }
        }
    }
    
    
    @IBAction func copounSC_Axn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
           
        code_TF.isHidden = true
        apply_Btn.isHidden = true
        
        } else {
        apply_Btn.isHidden = false
        code_TF.isHidden = false
        }
    }
    
    func postCopounData()  {
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
          
            let details = ["coupon_code":code_TF.text!]
        ApiService.postCall(url: ClientInterface.offersUrl, params: details, methodType: "POST", tag: "Offer", finish:finishPost)
         print("details = \(details)")
            
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection.", action: .alert)
        }
    }
    
    
    @IBAction func apply_Axn(_ sender: UIButton) {
        
        if code_TF.text == "" {
        popUpAlert(title: "Alert", message: "Enter Copoun Code", action: .alert)
        } else {
        postCopounData()
        }
    }
    
    
    
    
    
    
    
    
    
}
extension ApplicationFormVC3: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if callType_TF.isFirstResponder == true {
        return callType_Arr.count
        } else if callTime_TF.isFirstResponder == true {
        return callTime_Arr.count
        } else {
        return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if callType_TF.isFirstResponder == true {
        callType_TF.text = callType_Arr[row]
        } else  {
        callTime_TF.text = callTime_Arr[row]
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
        pickerLabel = UILabel()
        pickerLabel?.font = UIFont(name: "Optima-Bold", size: 15)
        pickerLabel?.textAlignment = .center
        }
        if callType_TF.isFirstResponder == true {
        pickerLabel?.text = callType_Arr[row]
        } else if callTime_TF.isFirstResponder == true  {
        pickerLabel?.text = callTime_Arr[row]
        } else  {
        pickerLabel?.text = ""
        }
        pickerLabel?.textColor = .white
        pickerLabel?.backgroundColor = .clear

        return pickerLabel!
    }
    
    
    
    
}