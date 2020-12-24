//
//  ViewController.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 05/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
 

class ViewController: UIViewController {
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var secureBtn: UIButton!
    @IBOutlet weak var forgotBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUPBtn: UIButton!
    @IBOutlet weak var rememberBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    var isClicked = false
    var ipAddress:String!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewChanges()
    }
    
    
    func viewChanges() {
        checkInternet()

        BookingDetails.ip_address = getIPAddress()!
        print("IP = \(BookingDetails.ip_address)")
        getMe()
        emailView.makeRound()
        passwordView.makeRound()
        loginBtn.makeRound()
//        AppUpdater.shared.showUpdate(withConfirmation: true)

    }
    
    
    func fetch_IPAddress() {
        if reach.isConnectedToNetwork() == true {
            ipAddress = getIPAddress()!
            print("ipAddress = \(ipAddress)")
            BookingDetails.ip_address = ipAddress
     
        } else {
            
            popUpAlert(title: "Check", message: "Check Internet Connection", action: .alert)
        }
    }
    
    
    
    @IBAction func back_Axn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    @IBAction func signUpAxn(_ sender: UIButton) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
        self.navigationController?.pushViewController(VC, animated: true)

        print("Suignup")
       
    }
    

    @IBAction func forgot_Axn(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotVC") as! ForgotVC
        VC.modalPresentationStyle = .fullScreen
        VC.modalTransitionStyle = .flipHorizontal
        self.present(VC, animated: true) {
            
        }
        print("Forgot")
        
    }
    
    
    @IBAction func rememberAxn(_ sender: UIButton) {
        if isClicked == false {
        isClicked = true
        sender.setImage(UIImage(named: "Check_W"), for: .normal)
        Preferrences.setRememberMe(status: true)
        } else {
        isClicked = false
        sender.setImage(UIImage(named: "un_chk"), for: .normal)
        Preferrences.setRememberMe(status: false)
        }
        
    }
    
    @IBAction func secureBtnAxn(_ sender: UIButton) {
        self.passwordSecurity(passTF: passwordTF, button: sender)

    }
    
    @IBAction func loginAxn(_ sender: UIButton) {


      if emailTF.text == "" || passwordTF.text == "" {
       popUpAlert(title: "Alert", message: "Enter All Details ", action: .alert)

        sender.shake()
       } else {
        postData()

        }
    }
    
    
    func postData()  {
        if reach.isConnectedToNetwork() == true {
          showActivityIndicator()
            
        let details = ["email":emailTF.text!,"password":passwordTF.text!] as [String:Any]
        ApiService.postCall(url: ClientInterface.loginUrl, params: details, methodType: "POST", tag: "Login", finish:finishPost)
         print("details = \(details)")
        } else {
        popUpAlert(title: "Alert", message: "Enter all details", action: .actionSheet)
            
        }
            
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
    
        hideActivityIndicator()
        
        do {
      
            if let jsonData = data {
    
            let parsedData = try JSONDecoder().decode(LoginResponse.self, from: jsonData)
                print(parsedData)
                
                if parsedData.status == true {
   
                    Preferrences.setUserLogin(status: true)
                userInfo()
               
//                    UserDetails.email = emailTF.text!
//                UserDetails.firstName = parsedData.data.first_name
//                UserDetails.lastName = parsedData.data.last_name
//                UserDetails.password = passwordTF.text!
//                UserDetails.mobileNumber = parsedData.data.mobile_number
//                UserDetails.id = parsedData.data.id
//                  
                    
                    Preferrences.setFirstName(type: parsedData.data.first_name)
                    Preferrences.setLastName(type: parsedData.data.last_name)
                    Preferrences.setUserPass(type: passwordTF.text!)
                    Preferrences.setUserEmail(type: emailTF.text!)
                    Preferrences.setUserMobile(type: parsedData.data.mobile_number)
                    Preferrences.setUserID(type: parsedData.data.id)
                    Preferrences.setUserDOB(type: parsedData.data.dob)

       
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(VC, animated: true)

        
                } else {
                popUpAlert(title: "Login Failed", message: "Error_Cheeck Details & Try Again", action: .alert)
                loginBtn.shake()
                    
                }
       
        
            } else {
            postData()
                
            }
        
        } catch {
       
            popUpAlert(title: "Alert", message: "Login Failed Check Details & Try Again ", action: .alert)
            loginBtn.shake()
       
            print("Parse Error: \(error)")
        }
        
    }
    
    

    func userInfo() {
        if Preferrences.getRememberMe() == true {
        Preferrences.setUserEmail(type: emailTF.text!)
        Preferrences.setUserPass(type: passwordTF.text!)
        } else {
        Preferrences.setUserEmail(type: "")
        Preferrences.setUserPass(type: "")
        }
    }
    
    func getMe() {
       
        if Preferrences.getRememberMe() == true {
        emailTF.text = Preferrences.getUserEmail()
        passwordTF.text = Preferrences.getUserPass()
        rememberBtn.setImage(UIImage(named: "Check_W"), for: .normal)
        
        } else {
        emailTF.text = ""
        passwordTF.text = ""
        rememberBtn.setImage(UIImage(named: "un_chk"), for: .normal)
        }
    }

}

