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
    
    @IBOutlet weak var covidLbl: UILabel!
    @IBOutlet weak var net_Price_Lbl: UILabel!
   
    
    @IBOutlet weak var GST_Lbl: UILabel!
    
    
    
    
    var isChecked:Bool = true
    var picker = UIPickerView()
    let callType_Arr = ["Skype","WhatsApp","Messenger","Google Duo"]
    let callTime_Arr = ["Morning [9 AM - 12 PM]","Noon[12 PM - 5 PM]","Evening [5 PM - 7 PM]"]
    var parent_Address = "NO"
    var weekendCall = "YES"
    let termsUrl = "https://camps.goexploreandaman.com/terms-and-conditions"
    let covidUrl = "https://camps.goexploreandaman.com/camp_covid19"

    let priceViewHeight: CGFloat = 240
    
    var copoun_Code = ""
    
    var basic_Price = 0.0
    var discount_Price = 0.0
    var net_Price = 0.0
    var tax_Price = 0.0
    var final_Price = 0
    var taxPercent = 0.0
    var img_Key_Arr:[String] = []
    var IMG_Data_Arr:[Data] = []
    override func viewDidLoad() {
        super.viewDidLoad()

       
        viewChanges()
    }
    

    func viewChanges() {
        checkInternet()

        copoun_View.layer.cornerRadius = 5
        apply_Btn.layer.cornerRadius = 5
        apply_Btn.layer.borderColor = UIColor.white.cgColor
        apply_Btn.layer.borderWidth = 0.5
        header_View.layer.cornerRadius = 10
        submit_Btn.makeBtnRound()
        package_Lbl.text = BookingDetails.package_name
        price_Lbl.text = BookingDetails.price
        age_Lbl.text = BookingDetails.age_Group
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .white
        let password_Tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            terms_Lbl.addGestureRecognizer(password_Tap)
        let covid_Tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            covidLbl.addGestureRecognizer(covid_Tap)
        
        copoun_Img.isHidden = true
        getGSTPercent()
        calculatePrices()
        if BookingDetails.photo.isEmpty == false {
            img_Key_Arr.append(BookingDetails.photo)
            IMG_Data_Arr.append(BookingDetails.photoImg)
        } else {
            print("NO Photo")
        }
        
        
        
        
        if BookingDetails.front_id_card.isEmpty == false {
            img_Key_Arr.append(BookingDetails.front_id_card)
            IMG_Data_Arr.append(BookingDetails.ID_Front_IMG)
        } else {
            print("NO Front IMg")

        }
        if BookingDetails.back_id_card.isEmpty == false {
            img_Key_Arr.append(BookingDetails.back_id_card)
            IMG_Data_Arr.append(BookingDetails.ID_Back_IMG)
        } else {
            print("NO Back IMg")

        }
        
        if BookingDetails.parent_front_id_card.isEmpty == false {
            img_Key_Arr.append(BookingDetails.parent_front_id_card)
            IMG_Data_Arr.append(BookingDetails.P_ID_Front_IMG)
        } else {
            print("NO Parent Front IMG")

        }
        if BookingDetails.parent_back_id_card.isEmpty == false {
            img_Key_Arr.append(BookingDetails.parent_back_id_card)
            IMG_Data_Arr.append(BookingDetails.P_ID_Back_IMG)
        } else {
            print("NO Parent Back IMG")

        }
        
        print("ImgDAta = \(IMG_Data_Arr)")
    }
    

    
      
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        
        if sender.view?.tag == 1 {
            
           
            guard let url = URL(string: covidUrl) else {
                                         return
                 }
                 if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }


        } else {
         guard let url = URL(string: termsUrl) else {
                                return
        }
        if UIApplication.shared.canOpenURL(url) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           }
   
        }
    }
    
    
    
    
    
        
    func calculatePrices() {
        basic_Price = Double(BookingDetails.price.fiterPrice()) ?? 0.0
        
        net_Price = basic_Price - discount_Price
        tax_Price = net_Price * (0.01 * taxPercent )

        final_Price = Int(net_Price + tax_Price)
        

        dPrice_Lbl.text = "\(discount_Price.rounded())"
        net_Price_Lbl.text = "\(net_Price)"
        taxPrice_Lbl.text = "\(tax_Price)"
        totalPrice_Lbl.text = "\(final_Price)"
        
        price_Lbl.text = "\(final_Price)"
        basePrice_Lbl.text = "\(basic_Price.rounded())"
        print("basic_Price = \(basic_Price)")
        print("tax_Price = \(tax_Price)")
        print("net_Price = \(net_Price)")
        print("discount_Price = \(discount_Price)")
        print("final_Price = \(final_Price)")

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
        showBottomView(View: price_View, height: priceViewHeight)
    }
    
    
    @IBAction func hidePrice_Axn(_ sender: UIButton) {
        hideBottomView(View: price_View, height: priceViewHeight)
    }
    
    @IBAction func submitBtn_Axn(_ sender: UIButton) {
       if p_FirstNameTF.text == "" || p_LastNameTF.text == "" || p_MobileTF.text == "" || alt_NumberTF.text == "" || P_EmailTF.text == "" || callType_TF.text == "" || callLink_TF.text == "" || callTime_TF.text == "" || p_street_TF.text == "" || p_Country_TF.text == "" || p_State_TF.text == "" || p_City_TF.text == "" || p_pincode_TF.text == "" {
        popUpAlert(title: "Alert", message: "Enter All Detials", action: .alert)
       
       } else if p_FirstNameTF.text!.isOnlyAlphabets() == false || p_LastNameTF.text!.isOnlyAlphabets() == false {
        popUpAlert(title: "Alert", message: "Names must be Alphabets", action: .alert)
       
       } else if p_MobileTF.text!.isValidContact() == false {
        popUpAlert(title: "Alert", message: "Enter a valid Mobile Number", action: .alert)

       } else if alt_NumberTF.text!.isValidContact() == false {
        popUpAlert(title: "Alert", message: "Enter a valid Alt-Mobile Number", action: .alert)

       } else if P_EmailTF.text!.isValidEmail() == false {
        
        popUpAlert(title: "Alert", message: "Enter a valid Email ", action: .alert)
      
       } else if p_Country_TF.text!.isOnlyAlphabets() == false {
        
        popUpAlert(title: "Alert", message: "Enter a valid Countrye ", action: .alert)

       } else if p_State_TF.text!.isOnlyAlphabets() == false {
        
        popUpAlert(title: "Alert", message: "Enter a valid State ", action: .alert)

       } else if p_pincode_TF.text!.count  != 6 {
        
        popUpAlert(title: "Alert", message: "Enter a vlaid Pincode ", action: .alert)

       
        
       } else if isChecked == false  {
        popUpAlert(title: "Alert", message: "Select Terms & Conditions", action: .alert)

       } else {
        postData()

        }
    }
    
    func postData()  {
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
           
            let details = ["ip_address":BookingDetails.ip_address, "user_id":BookingDetails.user_id, "package_id":BookingDetails.package_id, "package_name":BookingDetails.package_name, "price":basePrice_Lbl.text! , "offer_price":dPrice_Lbl.text! , "total_price":totalPrice_Lbl.text! , "quantity":"1", "seasonal_camp":BookingDetails.seasonal_camp, "camp_batch":BookingDetails.camp_batch, "first_name":BookingDetails.first_name, "middle_name":"", "last_name":BookingDetails.last_name, "dob":BookingDetails.DOB, "gender":BookingDetails.gender, "height":BookingDetails.height, "weight":BookingDetails.weight, "tshirt_size":BookingDetails.tshirt_size, "mother_tonque":BookingDetails.mother_tonque, "citizenship":BookingDetails.citizenship, "mobile_number":BookingDetails.mobile_number, "email":BookingDetails.email, "address":BookingDetails.street, "city":BookingDetails.city,  "country":BookingDetails.country, "pincode":BookingDetails.pincode, "medical_info":BookingDetails.medical_info, "medical_details":BookingDetails.medical_details, "treatments":BookingDetails.treatments, "treatments_details":BookingDetails.treatments_details, "p_first_name":p_FirstNameTF.text!, "p_middle_name":"", "p_last_name":p_LastNameTF.text!, "p_mobile_number":p_MobileTF.text!, "p_alt_mobile_number":alt_NumberTF.text!, "p_email":P_EmailTF.text!, "video_call":callType_TF.text!, "video_call_link":callLink_TF.text!, "weekend_call":weekendCall, "time_for_call":callTime_TF.text!, "parent_address":parent_Address, "p_address":p_street_TF.text!, "p_city":p_City_TF.text!, "p_country":p_Country_TF.text!, "p_pincode":p_pincode_TF.text!, "additional_details":addInfo_TF.text!,  "coupon_code":copoun_Code, "siblings_info":BookingDetails.siblingsInfo ,  "siblings_first_name":BookingDetails.siblingsFName, "siblings_middle_name":"", "siblings_last_name":BookingDetails.siblingsLName, "siblings_gender":BookingDetails.siblingsGender, "siblings_mobile_number":BookingDetails.siblingsMobile, "siblings_email":BookingDetails.siblingsEmail,
                "parent_id_number":BookingDetails.parent_id_number , "id_number":BookingDetails.id_number , "gst_number":BookingDetails.gst_number , "company_address":BookingDetails.company_address , "company_name":BookingDetails.company_name
            ]
            
            ApiService.uploadMultipleIMGwithParam(parameters: details, imageKey: img_Key_Arr, imgArr: IMG_Data_Arr, methodType: "POST", url: ClientInterface.bookingUrl, tag: "Booking", finish: finishPost)
            

      print("details = \(details)")
            
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection.", action: .alert)
        }
    }
    func getGSTPercent()  {
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
          
          
        ApiService.callPost(url: ClientInterface.GST_Url, params: "", methodType: "GET", tag: "GST", finish:finishPost)
            
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
                    let discount = Double(parsedData.discount ) ?? 0.0
                    discount_Price = basic_Price * 0.01 * discount
                    print("discount_Price = \(discount_Price)")
                    calculatePrices()
                    copoun_Code = code_TF.text!
                    popUpAlert(title: parsedData.message, message: "", action: .alert)
              
                
                } else {
                    copoun_Code = ""
                    discount_Price = 0.0
                    calculatePrices()
                    code_TF.shake()
                    copoun_Img.isHidden =  false
                    copoun_Img.image = UIImage(named: "cross2")
                    popUpAlert(title: "Alert", message: parsedData.message, action: .alert)
                    
                }
                } else {
                }
                } catch {
                    copoun_Img.image = UIImage(named: "cross2")

                popUpAlert(title: "Alert", message: "Copoun is not Valid", action: .alert)
                    discount_Price = 0
                    calculatePrices()
                print("Parse Error: \(error)")
                }
            
        } else if tag == "GST" {
            do {
                if let jsonData = data {
                let parsedData = try JSONDecoder().decode([GSTResponse].self, from: jsonData)
                print(parsedData)
                    for GST_Data in parsedData {
                        GST_Lbl.text = " GST - \(GST_Data.gst_percentage) % :(₹)"
                        taxPercent = Double(GST_Data.gst_percentage)!
                        print("taxPercent = \(taxPercent)")
                    }
                   
                    calculatePrices()

               
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
        copoun_View.isHidden = true

        } else {
        apply_Btn.isHidden = false
        code_TF.isHidden = false
            copoun_View.isHidden = false
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
        pickerLabel?.textColor = .black
        pickerLabel?.backgroundColor = .clear

        return pickerLabel!
    }
    
    
    
    
}
