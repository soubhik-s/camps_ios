//
//  ForgotVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 02/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class ForgotVC: UIViewController {

    
    
    @IBOutlet weak var email_View: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
       
    }
    
    func viewChanges(){
        checkInternet()

        email_View.makeRound()
        sendBtn.makeBtnRound()
        checkInternet()

    }

    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true) {
        
        }
    }
    
    
    @IBAction func sendBtn_Axn(_ sender: UIButton) {
        if emailTF.text == "" {
        popUpAlert(title: "Alert", message: "Enter Email", action: .alert)
        sendBtn.shake()
        
        } else if emailTF.text?.isValidEmail() == false {
        sendBtn.shake()
        popUpAlert(title: "Alert", message: "Check Email Format", action: .alert)
        sendBtn.shake()
        
        } else {
        postData()

        }
    }
    
     
        
    func postData()  {
        
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
        let details = ["email":emailTF.text!] as [String:Any]
        ApiService.postCall(url: ClientInterface.forgotPasswordUrl, params: details, methodType: "POST", tag: "Forgot", finish:finishPost)
        print("details = \(details)")
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .actionSheet)
        }
        
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        
        hideActivityIndicator()
        
        do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(PasswordResponse.self, from: jsonData)
            print(parsedData)
            
            if parsedData.status == true {
            alert(message: "Password has send to your Email", title: "Please Login.")
            
            } else {
            popUpAlert(title: "Alert", message: "\(parsedData.message)", action: .alert)
            }
            
            } else {
            popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
            }
            
        } catch {
        popUpAlert(title: "Alert", message: "Failed to send Password. Try Again. ", action: .alert)
        print("Parse Error: \(error)")
        }
        
    }
        
    
}
