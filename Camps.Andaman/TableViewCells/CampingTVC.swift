//
//  CampingTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 20/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class CampingTVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

   @IBOutlet weak var dataCV: UICollectionView!


    var campingDataArr:CampingListResponse = []
    
    let campingIMGUrl = "https://camps.goexploreandaman.com/assets/img/camping/"

        

           
    override func awakeFromNib() {
             super.awakeFromNib()
             CVChanges()
    }
            
        
    
    func CVChanges() {
       getData()
        dataCV.isHidden = true
        let cellSize = CGSize(width:150 , height:dataCV.frame.height)
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
   
    func getData()  {
       
        if reach.isConnectedToNetwork() == true {
        self.contentView.showActivityIndicator()
        ApiService.callPostToken(url: ClientInterface.campingUrl, params: "", methodType: "GET", tag: "Camping", finish:finishPost)

       } else {
        topMostController()?.popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

        }
    }

    func finishPost (message:String, data:Data? , tag: String) -> Void {

        self.contentView.hideActivityIndicator()
        
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(CampingListResponse.self, from: jsonData)
        print(parsedData)
        
            if parsedData.isEmpty == false {
                campingDataArr = parsedData
            }
            
            dataCV.isHidden = false

            dataCV.reloadData()


        }
        } catch {
           print("Parse Error: \(error)")

        }

    }
            
            
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campingDataArr.count
        
        }
            
            
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CampingCell", for: indexPath) as! CampingCVC

        let cellPath = campingDataArr[indexPath.row]
        
        cell.titleLbl.text = cellPath.campingName
        cell.IMGView.setImage(urlStr: campingIMGUrl + cellPath.campingImageLinkFirst)
        cell.IMGView.makeRounded()
                
            
            return cell
            
        
    }
            
       
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GestureVC") as! GestureVC
      
        let cellPath = campingDataArr[indexPath.row]

        GestureVariables.isGesture = false 
        GestureVariables.selected_Id = cellPath.campingID
        
        self.parentContainerViewController()?.navigationController?.pushViewController(VC, animated: true)


                
    }
    
}


