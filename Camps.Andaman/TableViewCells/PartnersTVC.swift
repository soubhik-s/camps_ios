//
//  PartnersTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 07/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class PartnersTVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
   

    @IBOutlet weak var dataCV: UICollectionView!
    
    
    
    var img_Arr = ["partner1","klm","tbo", "partner4", "partner5", "thai" , "AATA2"]
    
    override func awakeFromNib() {
        super.awakeFromNib()


        CVChanges()
    }

    func CVChanges() {
        let cellSize = CGSize(width:125 , height:dataCV.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 1.0
        dataCV.setCollectionViewLayout(layout, animated: true)
        dataCV.delegate = self
        dataCV.dataSource = self
        dataCV.showsHorizontalScrollIndicator = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img_Arr.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartnersCell", for: indexPath) as! PartnersCVC
        cell.IMG_View.image = UIImage(named: "\(img_Arr[indexPath.row])")
        
        cell.IMG_View.layer.cornerRadius = 10
        cell.IMG_View.layer.masksToBounds = true
        return cell
        
       }
       

}
