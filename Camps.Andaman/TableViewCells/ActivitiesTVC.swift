//
//  ActivitiesTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 26/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class ActivitiesTVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var dataCV: UICollectionView!
    

    var dataArr:ActivityResponse = []
   
    weak var delegate:GestureDelegate?

        
       
    override func awakeFromNib() {
            super.awakeFromNib()

            CVChanges()
        
    }
        
    
    func CVChanges() {
        dataCV.isHidden = true
        getData()

        let cellSize = CGSize(width:180 , height:130)
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
        ApiService.callPostToken(url: ClientInterface.activitiesUrl, params: "", methodType: "GET", tag: "Activity", finish:finishPost)

       } else {
        topMostController()?.popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

        }
    }

    func finishPost (message:String, data:Data? , tag: String) -> Void {


        self.contentView.hideActivityIndicator()


        do {

        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(ActivityResponse.self, from: jsonData)

        print(parsedData)

            if parsedData.isEmpty == false {
                dataArr = parsedData

            }
        print("ActivityData = \(dataArr)")
        
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
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitiesCell", for: indexPath) as! ActivitiesCVC

        let cellPath = dataArr[indexPath.row]
        cell.titleLbl.text = cellPath.activityName
        cell.IMGView.setImage(urlStr: ClientConfig.Activity_ImgUrl + cellPath.activityImageLink)
        cell.IMGView.layer.cornerRadius = 10
        
        return cell
        
    }
        

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let cellPath = dataArr[indexPath.row]
        
        ActivityVariables.locTitle = cellPath.activityName
        ActivityVariables.locIMG = cellPath.activityImageLink
        ActivityVariables.locDescription = cellPath.activityDescription

        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CampingVC") as! CampingVC

        self.parentContainerViewController()?.navigationController?.pushViewController(VC, animated: true)
        
        
    }
}
