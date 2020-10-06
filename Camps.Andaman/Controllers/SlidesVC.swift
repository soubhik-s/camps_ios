//
//  SlidesVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 12/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
import Razorpay
class SlidesVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var IMGView: UIImageView!
    
    @IBOutlet weak var myPageCntrl: UIPageControl!
    
    @IBOutlet weak var notesLbl: UILabel!
    
    @IBOutlet weak var logo_ImgView: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    var titleArr = ["CAMP WITH US","EXPERT GUIDE","MONITOR","SCHEDULE"]
    var notesArr = ["Andaman is the place that reflects the history of Indian independence that was studied in primary classes,know about the origin of some of the mankind and some of the tribal generations, play under the crystal clearsky and pristine beaches, reconnect with local culture and tourism, handicraft products and muchmore","Our team of experts will introduce you the service offerings that bestow to you at its utmost level. One of them is the summer campaign in which you can spend your holidays with fun and gain knowledge.","Each and every step of a candidate is monitored by our trained professionals in that particular􏰀 field. They will ensure that every child/adult is involved in all recreational activities; individual counselling is conducted to understand children/adult strengths and weakness.","Participant's daily schedule in such a way that it builds their self-con􏰀fidence along with catering the beautiful fun-fill􏰀ed moments."]
    var imagesArr = ["Splash Screen 2","Splash Screen 3","Splash Screen 4","Splash Screen 5"]
    var i=Int()

    let img_View = UIImageView()


    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

  
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUpdater.shared.showUpdate(withConfirmation: true)

//        print("appVersion = \(appVersion ?? "0")")
//        Preferrences.setAppVersion(type: appVersion)
        let gifImage = UIImage.gifImageWithName(name: "Camps2")
        logo_ImgView.image = gifImage
         
        firstImageFadeIn()

//         Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(imageChange), userInfo: nil, repeats: true)

    }
    @objc func imageChange(){
        self.IMGView.image = UIImage(named: "\(imagesArr[i])")
        if i<imagesArr.count-1{
            i+=1
        }
        else{
            i=0
        }
    }

    
  
    
   
    
    @IBAction func nextBtnAxn(_ sender: UIButton) {
        if reach.isConnectedToNetwork() == true {
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController

            self.navigationController?.pushViewController(VC, animated: true)
        
        } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }

        Preferrences.setInstalled(status: true)

        print("ISInstalled = \(Preferrences.getInstalled())")
    }
    
  
    func firstImageFadeIn() {
    
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .transitionCrossDissolve, animations: {
            self.myPageCntrl.currentPage = 0
                   self.titleLbl.text = self.titleArr[0]
                   self.notesLbl.text = self.notesArr[0]
                   self.IMGView.image = UIImage(named: "SS1")
        }, completion: {_ in
      
       
        self.secondImageFadeIn()
      })

    }
       
    
    func secondImageFadeIn() {
          
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .transitionCrossDissolve, animations: {
            self.myPageCntrl.currentPage = 1
            self.titleLbl.text = self.titleArr[1]
            self.notesLbl.text = self.notesArr[1]
            self.IMGView.image = UIImage(named: "SS2")
        }, completion: {_ in
        
        self.thirdImageFadeIn()
        })

    }
    
    func thirdImageFadeIn() {
          
      UIView.animate(withDuration: 2.0, delay: 2.0, options: .transitionCrossDissolve, animations: {
        self.myPageCntrl.currentPage = 2
                   self.titleLbl.text = self.titleArr[2]
                   self.notesLbl.text = self.notesArr[2]
               self.IMGView.image = UIImage(named: "SS3")
        }, completion: {_ in
           
        self.fourthImageFadeIn()
        })

    }
    
    func fourthImageFadeIn() {
          
      UIView.animate(withDuration: 2.0, delay: 2.0, options: .transitionCrossDissolve, animations: {
        self.myPageCntrl.currentPage = 3
        self.titleLbl.text = self.titleArr[3]
        self.notesLbl.text = self.notesArr[3]
        self.IMGView.image = UIImage(named: "SS4")
        }, completion: {_ in
        
        self.firstImageFadeIn()
        })

    }
    

}

    

