//
//  VerificationVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 06/07/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class VerificationVC: UIViewController {

  
    @IBOutlet weak var code_Lbl: UILabel!
    @IBOutlet weak var mobile_View: UIView!
    
    @IBOutlet weak var mobile_TF: UITextField!
    @IBOutlet weak var verifySV: UIStackView!
    @IBOutlet weak var send_Btn: UIButton!
    
    @IBOutlet weak var verify_btn: UIButton!
    
    @IBOutlet weak var codeTF: UITextField!
    
    var countryCode:String! = "+91"

    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {
        mobile_View.makeRound()
        send_Btn.makeRound()
        verifySV.isHidden = true
        verify_btn.makeBtnRound()
    }
    

    @IBAction func send_Axn(_ sender: UIButton) {
        if mobile_TF.text == "" {
            popUpAlert(title: "Alert", message: "Enter Mobile number", action: .alert)
        } else if mobile_TF.text!.isValidContact() == false  {
            popUpAlert(title: "Alert", message: "Enter Valid 10 Digit Mobile Number", action: .alert)
            
        } else {
        sendOTP()
//        if let phoneNumber = mobile_TF.text,
//            let countryCode = countryCode {
//            VerifyAPI.sendVerificationCode(countryCode, phoneNumber)
//            verifySV.isHidden = false
//        }
        }
        
    }
    
   
    @IBAction func verify_Axn(_ sender: UIButton) {
        if codeTF.text! == "" {
            popUpAlert(title: "Alert", message: "Enter the code", action: .alert)
       
        } else if codeTF.text!.count != 6 {
            popUpAlert(title: "Alert", message: "Enter the 6 didit Code", action: .alert)
        } else {
            showActivityIndicator()
//            verifyOTP()
           
            if let code = codeTF.text {
            VerifyAPI.validateVerificationCode(self.countryCode!, self.mobile_TF.text!, code) { checked in
                self.hideActivityIndicator()
                    if (checked.success) {
                         UserDetails.mobileNumber = self.mobile_TF.text!
                        let VC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
                        
                        self.navigationController?.pushViewController(VC, animated: true)
                        self.alert(message: "Mobile Number Verified", title: "Success")
                        
                        self.verifySV.isHidden = true
                        self.codeTF.text = ""
                    } else {
                        self.codeTF.shake()

                        self.popUpAlert(title: "Alert", message: checked.message, action: .alert)
                    }
                }
            }
        }
        
    }
    
    
    func sendOTP()  {
        
        if reach.isConnectedToNetwork() == true {
           showActivityIndicator()
        
            let details = ["via":"sms", "country_code":countryCode!,  "phone_number":mobile_TF.text!] as [String:Any]
          
            ApiService.postCall(url: ClientInterface.sendOTPUrl, params: details, methodType: "POST", tag: "Send", finish:finishPost)
           print("details = \(details)")
           } else {
           popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)            }
           
    }
  
    
    func verifyOTP()  {
    
    if reach.isConnectedToNetwork() == true {
       showActivityIndicator()
    
        let details = ["via":"sms", "country_code":"+91",  "phone_number":mobile_TF.text! , "verification_code":codeTF.text!] as [String:String]
        ApiService.postCall(url: ClientInterface.verifyOTPUrl, params: details, methodType: "POST", tag: "Verify", finish:finishPost)
       print("details = \(details)")
       
    } else {
       popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)            }
       }
       
       func finishPost (message:String, data:Data? , tag: String) -> Void {

           hideActivityIndicator()

           do {

           if let jsonData = data {
           let parsedData = try JSONDecoder().decode(OTPResponse.self, from: jsonData)
               print(parsedData)
           if parsedData.success == true {
            
            if tag == "Send" {
                popUpAlert(title: "Alert", message: "OTP Send to \(mobile_TF.text!)", action: .alert)
                verifySV.isHidden = false
            } else {
                verifySV.isHidden = true
                
                popUpAlert(title: "Success", message: "Mobile number Verified ", action: .alert)
                
            }
          
           } else {
            popUpAlert(title: "Alert", message: parsedData.message, action: .alert)
            
            }
           
           } else {
           popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
           }
          
           } catch {
           popUpAlert(title: "Alert", message: "Error_Cheeck Details", action: .alert)
           print("Parse Error: \(error)")
           }



       }
    
    
    @IBAction func back_Axn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true) {
//
//        }
    }
    
    
    
    
}
