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
    
   
    @IBOutlet weak var dataCV: UICollectionView!
    
    @IBOutlet weak var pageCntrl: UIPageControl!
    @IBOutlet weak var logo_ImgView: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    var titleArr = ["Camp with us","Expert Guide","Monitor","Schedule"]
    var notesArr = ["Andaman is the place that reflects the history of Indian independence that was studied in primary classes,know about the origin of some of the mankind and some of the tribal generations, play under the crystal clearsky and pristine beaches, reconnect with local culture and tourism, handicraft products and muchmore","Our team of experts will introduce you the service offerings that bestow to you at its utmost level. One of them is the summer campaign in which you can spend your holidays with fun and gain knowledge.","Each and every step of a candidate is monitored by our trained professionals in that particular􏰀 field. They will ensure that every child/adult is involved in all recreational activities individual counselling is conducted to understand children/adult strengths and weakness.","Participant's daily schedule in such a way that it builds their self con􏰀fidence along with catering the beautiful fun fill􏰀ed moments."]
    var imagesArr = ["Splash Screen 2","Splash Screen 3","Splash Screen 4","Splash Screen 5"]


    var timer = Timer()
    var counter = 0
     

    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

  
    override func viewDidLoad() {
        super.viewDidLoad()

//        print("appVersion = \(appVersion ?? "0")")
//        Preferrences.setAppVersion(type: appVersion)
        let gifImage = UIImage.gifImageWithName(name: "Camps2")
        logo_ImgView.image = gifImage
         

        CVChanges()

    }
    
    
    func CVChanges() {
        let cellSize = CGSize(width:dataCV.frame.size.width, height:dataCV.frame.size.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        dataCV.setCollectionViewLayout(layout, animated: true)
        dataCV.delegate = self
        dataCV.dataSource = self
        dataCV.reloadData()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func changeImage() {
    
    if counter < titleArr.count {
        let index = IndexPath.init(item: counter, section: 0)
        self.dataCV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        counter += 1
    } else {
        counter = 0
        let index = IndexPath.init(item: counter, section: 0)
        self.dataCV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        counter = 1
    }
        
    }

    
  
    
   
    
    @IBAction func nextBtnAxn(_ sender: UIButton) {
        if reach.isConnectedToNetwork() == true {
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController

            self.navigationController?.pushViewController(VC, animated: true)
        
        } else {
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
        }

        Preferrences.setInstalled(status: true)

        print("ISInstalled = \(Preferrences.getInstalled())")
    }
    
  
   


}

extension SlidesVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SlidersCVCell
        
        cell.Title_Lbl.text = titleArr[indexPath.item]
        cell.notes_Lbl.text = notesArr[indexPath.item]
        cell.BG_IMG_View.image = UIImage(named: imagesArr[indexPath.item])
        pageCntrl.numberOfPages = titleArr.count
        
        pageCntrl.currentPage = indexPath.item
        
        
        return cell
        
    }
    
    
    
    
    
    
    
}

    

