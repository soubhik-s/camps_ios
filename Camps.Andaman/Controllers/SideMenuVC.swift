//
//  SideMenuVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 05/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var userIMGView: UIImageView!
    
    
    @IBOutlet weak var dataTV: UITableView!
    
    @IBOutlet weak var linkedIn_Btn: UIButton!
    
    @IBOutlet weak var youtube_Btn: UIButton!
    
    @IBOutlet weak var twitter_Btn: UIButton!
   
    
    @IBOutlet weak var insta_Btn: UIButton!
    @IBOutlet weak var fb_Btn: UIButton!
    
    var menuList = ["My Dashborad", "Profile","Customer Support", "About Us", "FAQ's","Policy","Logout"]
    var IMGList = ["Dashboard","profile", "support_1","About_us","FAQ's","insurance", "Logout"]
    
    
    
    
    
    let url_Arr = ["https://www.instagram.com/camps_goexploreandaman","https://www.facebook.com/pg/Campsgoexploreandaman-107662424239271/services/?ref=page_internal","https://twitter.com/Campsgoexplore1","https://www.youtube.com/channel/UCwNKHrESY3sVqjsfAt7vMuw?view_as=subscriber","https://www.linkedin.com/company/goexploreandaman"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        viewChanges()
    }
    
    func viewChanges() {
        
        let gifImage = UIImage.gifImageWithName(name: "Camps2")
        userIMGView.image = gifImage
        
        dataTV.rowHeight = 50
        dataTV.reloadWithAnimation()
        
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
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
            self.navigationController?.pushViewController(VC, animated: true)
            
            
        case 1 :
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            VC.modalPresentationStyle = .fullScreen
            present(VC, animated: true) {
                
            }
            
        case 2:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "SupportVC") as! SupportVC
            
            VC.modalPresentationStyle = .fullScreen

            self.present(VC, animated: true) {
                           
            }
            
            
        case 3:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true) {
                
            }
      
            
        case 4:
        
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
        
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true) {
                           
            }
        case 5 :
        
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PolicyVC") as! PolicyVC
       
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true) {
                       
        }
            
        case 6 :
            
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(VC, animated: true)
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
