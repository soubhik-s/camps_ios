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


    var dataArr:CampingResponse = []
    var img_Arr:[String]  = []
    var title_Arr:[String] = []
    var description_Arr:[String] = []
    var activity_arr:[String] = []
    weak var delegate:CampingDelegate?

         

           
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
        ApiService.callPostToken(url: ClientInterface.campingUrl, params: "", methodType: "GET", tag: "Camping", finish:finishPost)

       } else {
        topMostController()?.popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

        }
    }

    func finishPost (message:String, data:Data? , tag: String) -> Void {

        self.contentView.hideActivityIndicator()
        
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(CampingResponse.self, from: jsonData)
        print(parsedData)
        
            dataArr = parsedData
            print("CmapingData = \(dataArr)")
            for adultData in dataArr {

            title_Arr.append(adultData.campingName)
            print("Campingtitle_Arr = \(title_Arr)")

            let imgUrlStr = "https://camps.goexploreandaman.com/assets/img/camping/" + adultData.campingImageLink
            img_Arr.append(imgUrlStr)
            print("CampingimgArr = \(img_Arr)")
            description_Arr.append(adultData.campingDescription)
                print("description_Arr = \(description_Arr)")
            activity_arr.append(adultData.campingActivity)
                print("activity_arr = \(activity_arr)")
            }

            dataCV.isHidden = false

            dataCV.reloadData()


        } else {
        getData()
        }
        } catch {
        getData()
           print("Parse Error: \(error)")

        }

    }
            
            
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return title_Arr.count
        
        }
            
            
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CampingCell", for: indexPath) as! CampingCVC

            cell.titleLbl.text = title_Arr[indexPath.row]
            cell.IMGView.setImage(urlStr: "\(img_Arr[indexPath.row])")
            cell.activityLbl.text = activity_arr[indexPath.row]
            cell.decriptionLbl.text = description_Arr[indexPath.row]
            cell.IMGView.makeRounded()
                
            
            return cell
            
        }
            
       
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            BookingDetails.selectedIndex = indexPath.row
            print("Selected Index = \(BookingDetails.selectedIndex)")
        
            
            let cell = collectionView.cellForItem(at: indexPath) as! CampingCVC
            LocationVariables.locTitle = cell.titleLbl.text!
            LocationVariables.locIMG = (cell.IMGView.image?.toString()!)!
        LocationVariables.locDescription = cell.decriptionLbl.text!
           LocationVariables.locActitvity = cell.activityLbl.text!
            if delegate != nil {
                delegate?.onItemTapped()
            }
                
    }
    
}


