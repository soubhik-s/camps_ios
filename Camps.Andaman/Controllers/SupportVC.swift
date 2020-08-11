//
//  SupportVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 03/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
import MessageUI

class SupportVC: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var IMG_View: UIImageView!
    
    
    
    @IBOutlet weak var call_View1: UIView!
    
    @IBOutlet weak var call_View_2: UIView!
    
    @IBOutlet weak var mail_View: UIView!
   
    @IBOutlet weak var email_TF: UITextField!
    
    @IBOutlet weak var email_View: UIView!
    
    @IBOutlet weak var subscribe_Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    func viewChanges() {
        
        IMG_View.layer.cornerRadius = 10
        call_View1.makeRound()
        call_View_2.makeRound()
        mail_View.makeRound()
        email_View.makeRound()
        subscribe_Btn.makeBtnRound()
        let call_Tap_1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let call_Tap_2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let mail_Tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            call_View1.addGestureRecognizer(call_Tap_1)
           
            mail_View.addGestureRecognizer(call_Tap_2)
            call_View_2.addGestureRecognizer(mail_Tap)
        }
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            switch sender.view?.tag {
            case 0:
                print("call1")
                let phoneURL = NSURL(string: ("tel://" + "+91-9632692619"))
               UIApplication.shared.open(phoneURL! as URL, options: [:], completionHandler: nil)

            case 1:
                print("call2")
                let phoneURL = NSURL(string: ("tel://" + "+91-8900927716"))
                UIApplication.shared.open(phoneURL! as URL, options: [:], completionHandler: nil)
            case 2:
                print("mail")
                sendMail()
            default:
                break
            }
        }
    
    
    @IBAction func back_Axn(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }
    
    
    
    
    @IBAction func subscribe_Btn_Axn(_ sender: UIButton) {
        
        if email_TF.text == "" {
        sender.shake()
        self.view.makeToast("Enter email to subscribe")
        } else if email_TF.text?.isValidEmail() == false {
        sender.shake()
        self.view.makeToast("Enter Valid Email..")
        }
        else {
            postData()
        }
    }
    
    
    func sendMail() {
        
        //TODO:  You should chack if we can send email or not
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@goexploreandaman.com"])
            mail.setSubject("Enquiery")
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            print("Application is not able to send an email")
        }
        
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    func postData()  {
        
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
        let details = ["email":email_TF.text!] as [String:Any]
        ApiService.postCall(url: ClientInterface.subscriptionUrl, params: details, methodType: "POST", tag: "Subscription", finish:finishPost)
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
                self.view.makeToast("Thanks for Subscription.:)")
            } else {
                self.view.makeToast("\(parsedData.message)")
            }
            
            } else {
            self.view.makeToast("Error in Connecting Server..Try Again.")
            }
            
        } catch {
        self.view.makeToast("Error in Connecting Server..Try Again.")
        print("Parse Error: \(error)")
        }
        
    }
    
    
    
   
}
