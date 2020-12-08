//
//  SideMenuVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 05/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
//import SideMenu
class SideMenuVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var login_Btn: UIButton!
    
    @IBOutlet weak var dataTV: UITableView!
    
    @IBOutlet weak var linkedIn_Btn: UIButton!
    
    @IBOutlet weak var youtube_Btn: UIButton!
    
    @IBOutlet weak var twitter_Btn: UIButton!
   
    
    @IBOutlet weak var insta_Btn: UIButton!
    @IBOutlet weak var fb_Btn: UIButton!
    
    var menuList = ["My Dashborad", "Profile","Blog","Benefits" , "Why Choose us..?", "Health Guidelines","Customer Support", "About Us", "FAQ's","Policy"]
    var IMGList = ["Dashboard","profile","blog","fire2","why", "icons8-virus-free-30", "support_1","About","FAQ's","insurance"]
    
    let covid_Url = "https://camps.goexploreandaman.com/camp_covid19"
    
    
    
    let url_Arr = ["https://www.instagram.com/camps_goexploreandaman","https://www.facebook.com/pg/Campsgoexploreandaman-107662424239271/services/?ref=page_internal","https://twitter.com/Campsgoexplore1","https://www.youtube.com/channel/UCwNKHrESY3sVqjsfAt7vMuw?view_as=subscriber","https://www.linkedin.com/company/goexploreandaman"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        viewChanges()
    }
    
    func viewChanges() {
        
        if Preferrences.getUserLogin() == true {
            login_Btn.setTitle("Logout", for: .normal)
            login_Btn.tag = 1
            
        } else {
            login_Btn.tag = 0

            login_Btn.setTitle("Login", for: .normal)

        }
//        let gifImage = UIImage.gifImageWithName(name: "Camps2")
//        userIMGView.image = gifImage
        dataTV.rowHeight = 50
        dataTV.reloadWithAnimation()
        
    }
    
   
    @IBAction func loginBtn_Axn(_ sender: UIButton) {
        if sender.tag == 1 {
            login_Btn.tag = 0

            login_Btn.setTitle("Login", for: .normal)
            Preferrences.setUserLogin(status: false)
            popUpAlert(title: "Alert", message: "Looged Out", action: .alert)
        } else {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(VC, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuTVC
        
        cell.IMGView.image = UIImage(named: "\(IMGList[indexPath.row])")
        cell.titleLbl.text = menuList[indexPath.row]
        cell.dataView.layer.cornerRadius = 5
        return cell
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        switch indexPath.row {
        case 0:
            
            if Preferrences.getUserLogin() == true {
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
                self.navigationController?.pushViewController(VC, animated: true)
            } else {
                popUpAlert(title: "Alert", message: "Login to Check the Dashboard Details", action: .alert)
            }
          
            
            
        case 1 :
            
            if Preferrences.getUserLogin() == true {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            VC.modalPresentationStyle = .fullScreen
            present(VC, animated: true) {
                
            }
            } else {
                popUpAlert(title: "Alert", message: "Login to View Profile Details", action: .alert)
            }
        case 2 :
        
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "BlogVC") as! BlogVC
  

            self.navigationController?.pushViewController(VC, animated: true)
//            VC.modalPresentationStyle = .fullScreen
//
//            present(VC, animated: true) {
//                
//            }
            
            case 3:
                               
                      
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "BenefitsVC") as! BenefitsVC
                                  
            VC.modalPresentationStyle = .fullScreen

            self.present(VC, animated: true) {
                                                 
            }
            
        case 4:
                               
                     
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "WhyVC") as! WhyVC
                                  
            VC.modalPresentationStyle = .fullScreen

            self.present(VC, animated: true) {
                                                 
            }
            
            case 5:
                guard let url = URL(string: covid_Url) else {
                     return
                 }
             
                if UIApplication.shared.canOpenURL(url) {
                     UIApplication.shared.open(url, options: [:], completionHandler: nil)
                 }
//                let VC = self.storyboard?.instantiateViewController(withIdentifier: "CovidVC") as! CovidVC
//
//
//                VC.modalPresentationStyle = .fullScreen
//
//                self.present(VC, animated: true) {
//
//                       }
        case 6:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "SupportVC") as! SupportVC
            
            VC.modalPresentationStyle = .fullScreen

            self.present(VC, animated: true) {
                           
            }
            
            
        case 7:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true) {
                
            }
      
            
        case 8:
        
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
        
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true) {
                           
            }
        
        case 9 :
        
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PolicyVC") as! PolicyVC
       
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true) {
                       
        }
            
        
        default:
            break
        }
    }

    
    
    
    
    @IBAction func social_NetworkAxn(_ sender: UIButton) {
        
        

        switch sender.tag {
        case 0:
            guard let url = URL(string: "\(url_Arr[0])") else {
                 return
             }
         
            if UIApplication.shared.canOpenURL(url) {
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
             }
            
        case 1:
        guard let url = URL(string: "\(url_Arr[1])") else {
             return
         }
        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
         }
        
        case 2:
        guard let url = URL(string: "\(url_Arr[2])") else {
             return
         }
        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
         }
        
        case 3:
        guard let url = URL(string: "\(url_Arr[3])") else {
             return
         }
        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
         }
        case 4 :
        guard let url = URL(string: "\(url_Arr[4])") else {
                 return
        }
        
        if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        default:
            break
        }
        
       
        
        
    }
    
}
