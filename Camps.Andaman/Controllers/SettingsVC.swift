//
//  SettingsVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 12/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var oldPassTF: UITextField!
    @IBOutlet weak var firstName_TF: UITextField!
    
    @IBOutlet weak var LName_View: UIView!
    @IBOutlet weak var FName_View: UIView!
    @IBOutlet weak var arr_IMG: UIImageView!
    
    @IBOutlet weak var lastName_TF: UITextField!
    @IBOutlet weak var oldPass_View: UIView!
    
    @IBOutlet weak var mobile_TF: UITextField!
    @IBOutlet weak var email_TF: UITextField!
    @IBOutlet weak var userIMGView: UIImageView!
    
    @IBOutlet weak var newPassTF: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var passView: UIView!
    
    @IBOutlet weak var newPass_View: UIView!
    
    
    @IBOutlet weak var mail_View: UIView!
    
    @IBOutlet weak var mobile_View: UIView!
    var isClicked:Bool = false
    var  pickedImage:UIImage!

    @IBOutlet weak var stackSV: UIStackView!
    
    @IBOutlet weak var update_Btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
        
    }
    func viewChanges() {
        
        FName_View.makeRound()
        LName_View.makeRound()
        update_Btn.makeRound()
        mail_View.makeRound()
        mobile_View.makeRound()
        passView.makeRound()
        oldPass_View.makeRound()
        newPass_View.makeRound()
        doneBtn.makeBtnRound()
        userIMGView.makeRounded()
        
        if UserDetails.email != "" {
        email_TF.text = UserDetails.email
        mobile_TF.text = UserDetails.mobileNumber
        firstName_TF.text = UserDetails.firstName
        lastName_TF.text = UserDetails.lastName
        }
        
        if Preferrences.getUserID() == UserDetails.id {
            if Preferrences.getUserIMG() != "" {
                userIMGView.image = Preferrences.getUserIMG().toImage()
            } else {
                print("Imgae is nill")
            }
        } else {
            print("ID Doesnt Match")
        }
        
       
        oldPass_View.isHidden = true
        newPass_View.isHidden = true
        doneBtn.isHidden = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        userIMGView.isUserInteractionEnabled = true
        userIMGView.addGestureRecognizer(tap)
        let password_Tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        passView.addGestureRecognizer(password_Tap)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.view?.tag == 1 {
        changePass()
        } else {
        print("Image Tapped")
        openGallery()
        }
        
       

    }
    
    func changePass() {
       
        if isClicked == false {
        
            isClicked = true
            arr_IMG.image = UIImage(named: "up_2")
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.5, options: [], animations:
                {
            self.oldPass_View.isHidden = false
            self.newPass_View.isHidden = false
            self.doneBtn.isHidden = false
            self.update_Btn.isHidden = true

             self.stackSV.transform = CGAffineTransform(scaleX: 1, y: 1)
        
            }, completion: nil)
        
            oldPass_View.alpha = 1
            newPass_View.alpha = 1
             doneBtn.alpha = 1
             update_Btn.alpha = 0

        } else {
            
            oldPass_View.alpha = 0
            newPass_View.alpha = 0
            doneBtn.alpha = 0
            update_Btn.alpha = 1
            isClicked = false
            arr_IMG.image = UIImage(named: "down13")
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.5, options: [], animations:
                    {
            
                self.oldPass_View.isHidden = true
                self.newPass_View.isHidden = true
                self.doneBtn.isHidden = true
                self.update_Btn.isHidden = false
                self.stackSV.transform = CGAffineTransform(scaleX: 1, y: 1)
        
            }, completion: nil)
            
          
        }
    }
    
    // image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {

        pickedImage = info[.editedImage] as? UIImage
        userIMGView.image = pickedImage
        print("Image is picked")
        picker.dismiss(animated: true) {
            Preferrences.setUserID(type: UserDetails.id)
            Preferrences.setUserIMG(type: (self.userIMGView.image?.toString())!)
            print("Image Saved")
        }
        
        
        
    }
    
    @IBAction func back_Axn(_ sender: UIButton) {
        
        dismiss(animated: true) {
            
        }

    }
    @IBAction func secure_Axn(_ sender: UIButton) {
        if sender.tag == 1 {
        self.passwordSecurity(passTF: newPassTF, button: sender)
        
        } else {
        self.passwordSecurity(passTF: oldPassTF, button: sender)
        }
        
    }
    
    
    
    @IBAction func update_Btn(_ sender: UIButton) {
        if firstName_TF.text == "" || lastName_TF.text == "" || email_TF.text! == "" || mobile_TF.text == "" {
            popUpAlert(title: "Alert", message: "Enter All Details", action: .alert)
        } else if email_TF.text!.isValidEmail() == false {
        popUpAlert(title: "Alert", message: "Enter Valid Email", action: .alert)
        
        } else if mobile_TF.text!.isValidContact() == false {
        popUpAlert(title: "Alert", message: "Enter Valid Mobile Number", action: .alert)
        } else {
        updateProfile()
        }
    }
    
    
    
    @IBAction func done_Axn(_ sender: UIButton) {
        if oldPassTF.text == "" || newPassTF.text == "" {
        popUpAlert(title: "Alert", message: "Enter Passwords", action: .alert)
        
        } else if  oldPassTF.text == newPassTF.text {
        popUpAlert(title: "Alert", message: "Old & New Password should not be same.. ", action: .alert)
        
        } else {
        postData()
        }
    }
    
    func updateProfile() {
       if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
        let details = ["user_id":UserDetails.id, "first_name":firstName_TF.text!, "last_name":lastName_TF.text!, "email":email_TF.text! , "mobile_number":mobile_TF.text! ] as [String:Any]
        ApiService.postCall(url: ClientInterface.registrationUrl, params: details, methodType: "PUT", tag: "Profile", finish:finishPost)
        print("details = \(details)")
   
       } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .actionSheet)
        
        }
    
    }
    
    
    func postData()  {
                               
       if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
        let details = ["user_id":UserDetails.id, "old_password":oldPassTF.text!, "new_password":newPassTF.text!] as [String:Any]
        ApiService.postCall(url: ClientInterface.changePasswordUrl, params: details, methodType: "POST", tag: "Change", finish:finishPost)
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
                       
            if tag == "Profile" {
            popUpAlert(title: "Success", message: "Profile Updated ", action: .alert)

                UserDetails.firstName = firstName_TF.text!
                UserDetails.lastName = lastName_TF.text!
                UserDetails.email = email_TF.text!
                UserDetails.mobileNumber = mobile_TF.text!
            } else {
                oldPass_View.isHidden = true
                newPass_View.isHidden = true
                doneBtn.isHidden = true
                oldPassTF.text = ""
                newPassTF.text = ""
                arr_IMG.image = UIImage(named: "down")
                popUpAlert(title: "Success", message: "Password changed ", action: .alert)
            }
            
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
