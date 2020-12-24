//
//  SignUpVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 05/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var lastName_TF: UITextField!
    @IBOutlet weak var firstName_Tf: UITextField!
    @IBOutlet weak var first_View: UIView!
    @IBOutlet weak var last_View: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var DOB_View: UIView!
    
    @IBOutlet weak var DOB_TF: UITextField!
    @IBOutlet weak var location_View: UIView!
    @IBOutlet weak var location_TF: UITextField!
    var user_Gender = "Male"
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
        
    }
    
    func viewChanges() {
        checkInternet()

        mobileTF.text = Preferrences.getUserMobile()
        passwordView.makeRound()
        first_View.makeRound()
        last_View.makeRound()
        emailView.makeRound()
        mobileView.makeRound()
        signUpBtn.makeRound()
        DOB_View.makeRound()
        location_View.makeRound()
    }
    

    @IBAction func backAxn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func secureBtnAxn(_ sender: UIButton) {
       
       self.passwordSecurity(passTF: passwordTF, button: sender)

    }
    
    
    @IBAction func loginAxn(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
       
        self.navigationController?.pushViewController(VC, animated: true)
       
    }
    
    
    @IBAction func signUpAxn(_ sender: UIButton) {
        
        if emailTF.text == "" || passwordTF.text == "" || mobileTF.text == "" || firstName_Tf.text == "" || lastName_TF.text == "" || DOB_TF.text == "" {
        signUpBtn.shake()
        popUpAlert(title: "Alert", message: "Enter all Details", action: .alert)
      
        } else if firstName_Tf.text!.isOnlyAlphabets() == false || lastName_TF.text!.isOnlyAlphabets() == false {
            popUpAlert(title: "Alert", message: "Name - Enter only Alphabets", action: .alert)

        } else if emailTF.text?.isValidEmail() == false {
        signUpBtn.shake()
        popUpAlert(title: "Alert", message: "Enter a Valid Email", action: .alert)
        
        } else {
        postData()
        }
        
    }
    
    
    
    @IBAction func genderSC_Axn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            user_Gender = "Female"
        } else {
            user_Gender = "Male"

        }
        
    }
    
    
    @IBAction func dobTF_Axn(_ sender: UITextField) {
        sender.pastDatePicker()
    }
    
    func postData()  {
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
            let details = ["first_name":firstName_Tf.text!, "last_name":lastName_TF.text!, "email":emailTF.text!, "mobile_number":mobileTF.text!, "password":passwordTF.text! , "dob":DOB_TF.text! ,"gender":user_Gender , "location":location_TF.text!
                ] as [String:Any]
            
        ApiService.postCall(url: ClientInterface.registrationUrl, params: details, methodType: "POST", tag: "Signup", finish:finishPost)
        print("details = \(details)")
        } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)            }
        }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {

        hideActivityIndicator()

        do {

        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(SignupResponse.self, from: jsonData)
            print(parsedData)
        if parsedData.status == true {
            firstName_Tf.text = ""
            lastName_TF.text = ""
            emailTF.text = ""
            passwordTF.text = ""
             mobileTF.text = ""
            DOB_TF.text = ""
            location_TF.text = ""
            let VC = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(VC, animated: true)
            popUpAlert(title: "Success", message: "Registration Completed", action: .alert)
          
        } else {
        popUpAlert(title: "Alert", message: "Error_Cheeck Details", action: .alert)
        }
        } else {
        popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
        }
        } catch {
        popUpAlert(title: "Alert", message: "Error_Cheeck Details", action: .alert)
        print("Parse Error: \(error)")
        }



    }
    
    

    
    
}
