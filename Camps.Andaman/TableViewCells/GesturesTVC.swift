//
//  GesturesTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 26/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class GesturesTVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var dataCV: UICollectionView!
   
    var dataArr:GestureResonse = []
    
    let gestureIMGUrl = "https://camps.goexploreandaman.com/assets/img/gesture/"

     
        override func awakeFromNib() {
            super.awakeFromNib()

            CVChanges()
        
    }
        
    
    func CVChanges() {
        getData()
        dataCV.isHidden = true
        let cellSize = CGSize(width:130 , height:130)
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
        ApiService.callPostToken(url: ClientInterface.gesturesUrl, params: "", methodType: "GET", tag: "Gesture", finish:finishPost)

       } else {
        topMostController()?.popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

        }
    }

    func finishPost (message:String, data:Data? , tag: String) -> Void {
        
        self.contentView.hideActivityIndicator()
        
        do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(GestureResonse.self, from: jsonData)

            print(parsedData)

            if parsedData.isEmpty == false {
            dataArr = parsedData
                
            }
            print("GestureData = \(dataArr)")
            dataCV.isHidden = false
            dataCV.reloadData()

        }
          
        } catch {
           print("Parse Error: \(error)")

        }

}
        
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dataArr.count
    
    }
        
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GestureCell", for: indexPath) as! GestureCVC

        let cellPath = dataArr[indexPath.row]
        cell.titleLbl.text = cellPath.gestureName
        cell.IMGView.setImage(urlStr: gestureIMGUrl + cellPath.gestureImageLinkFirst)
                

        cell.IMGView.makeRounded()
            
        
        return cell
        
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellPath = dataArr[indexPath.row]

        GestureVariables.selected_Id = cellPath.gestureID
        
        
        
        GestureVariables.isGesture = true
        GestureVariables.selected_Id = cellPath.gestureID
        
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GestureVC") as! GestureVC

        self.parentContainerViewController()?.navigationController?.pushViewController(VC, animated: true)


           
    }
}
