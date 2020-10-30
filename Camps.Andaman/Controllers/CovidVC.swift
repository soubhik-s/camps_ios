//
//  CovidVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 13/10/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class CovidVC: UIViewController, UITableViewDelegate , UITableViewDataSource, UICollectionViewDelegate , UICollectionViewDataSource {
   
    
   
    @IBOutlet weak var IMG_CV: UICollectionView!
    
    @IBOutlet weak var dataTV: UITableView!
    
    var timer = Timer()
    var counter = 0

    let IMG_Arr = ["covid1","covid2","covid3","covid4"]
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    
    func viewChanges() {
        dataTV.delegate = self
        dataTV.dataSource = self
        dataTV.reloadWithAnimation()
        CVChanges()
    
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            
        }
               
          
    }
           
    
    @objc func changeImage() {
           
        if counter < IMG_Arr.count {
        
        let index = IndexPath.init(item: counter, section: 0)
        self.IMG_CV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
               counter += 1
        
        } else {
        
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.IMG_CV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            
            counter = 1
           
        }
               
        
    }
    
    func CVChanges() {
          
        let cellSize = CGSize(width:IMG_CV.frame.width , height:IMG_CV.frame.height)
        
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal //.horizontal
            layout.itemSize = cellSize
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 1.0
            IMG_CV.setCollectionViewLayout(layout, animated: true)
            IMG_CV.delegate = self
            IMG_CV.dataSource = self
            IMG_CV.showsHorizontalScrollIndicator = false
       
        IMG_CV.reloadData()
              
         
    }

    @IBAction func back_Axn(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IMG_Arr.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogCVCell", for: indexPath) as! BlogDetailsCVC
        if PrivacyVariables.isPrivacy == true {
            cell.IMG_View.image = UIImage(named: "Policy")

        } else {
        cell.IMG_View.image = UIImage(named: IMG_Arr[indexPath.row])
        cell.myPageCntrl.numberOfPages = IMG_Arr.count
        cell.myPageCntrl.currentPage = indexPath.item
            
        }
        return cell
        
     
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          
        return 1
        
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    
    return cell
  }
  

}
