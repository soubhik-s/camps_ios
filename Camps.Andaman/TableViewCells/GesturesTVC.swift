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
    var title_Arr2 = ["TREKKING","KAYAKING","BIRD WATCHING","CELLULAR JAIL"]
    var img_Arr2 = ["trek_2","kayaking","BIRD_WATCH","JAIL",]
    var dataArr:GestureResponse = []
    var img_Arr:[String]  = []
    var title_Arr:[String] = []
    var description_Arr:[String] = []
       

   weak var delegate:GestureDelegate?

        
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
            let parsedData = try JSONDecoder().decode(GestureResponse.self, from: jsonData)

            print(parsedData)


            dataArr = parsedData
            print("GestureData = \(dataArr)")
            for adultData in dataArr {
                title_Arr.append(adultData.gestureName)
               print("Gesturetitle_Arr = \(title_Arr)")

            let imgUrlStr = "https://camps.goexploreandaman.com/assets/img/gesture/" + adultData.gestureImageLink
            img_Arr.append(imgUrlStr)
            print("GestureIMGArr = \(img_Arr)")
 
                description_Arr.append(adultData.gestureDescription)
            }
            dataCV.isHidden = false
            dataCV.reloadData()

        }
          
        } catch {
           print("Parse Error: \(error)")

        }

}
        
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return title_Arr.count
    
    }
        
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GestureCell", for: indexPath) as! GestureCVC

        cell.titleLbl.text = title_Arr[indexPath.row]
        cell.IMGView.setImage(urlStr: "\(img_Arr[indexPath.row])")
        cell.descriptionLbl.text = description_Arr[indexPath.row]
          
        cell.IMGView.makeRounded()
            
        
        return cell
        
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GestureCVC
        GestureVariables.Title = cell.titleLbl.text!
        GestureVariables.IMG = (cell.IMGView.image?.toString()!)!
        GestureVariables.Description = cell.descriptionLbl.text!
        
//        self.onDidSelectItem?(indexPath)

        
        if delegate != nil {
            delegate?.onGestureItemTapped()
        }
           
    }
}
