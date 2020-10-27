//
//  ChildTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 26/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class ChildTVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var dataCV: UICollectionView!
    
    

    var dataArr:PackageResponse = []
  
   let IMG_Url = "https://camps.goexploreandaman.com/assets/images/photo/"


      
    override func awakeFromNib() {
        super.awakeFromNib()

        
        CVChanges()
    
    
    }
        
    
    func CVChanges() {

        dataCV.isHidden = true
        getData()
        
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

        ApiService.callPostToken(url: ClientInterface.packagesUrl, params: "", methodType: "GET", tag: "Child", finish:finishPost)

        } else {
        topMostController()?.popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

        }



    }


    func finishPost (message:String, data:Data? , tag: String) -> Void {

        self.contentView.hideActivityIndicator()

        do {

        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(PackageResponse.self, from: jsonData)
        print(parsedData)

           if parsedData.isEmpty == false {
            for adultData in parsedData {
                if adultData.age_group != "adult" {
                    dataArr.append(adultData)
                    
                }
                
            }
            
            dataCV.isHidden = false
            dataCV.reloadData()
            
            }
            
        }
        } catch {
            print("Parse Error: \(error)")
        }

}
        
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    
    }
        

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChildCell", for: indexPath) as! ChildCVC
        let cellPath = dataArr[indexPath.row]

        if cellPath.age_group == "children" {
            cell.titleLbl.text = cellPath.package_title
            cell.durationLbl.text = cellPath.package_description
            cell.priceLbl.text = "₹ \(cellPath.package_price)"
            cell.IMGView.setImage(urlStr: IMG_Url + cellPath.package_image_name)
        }
        
            
            cell.IMGView.layer.cornerRadius = 10
            
            return cell
        }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ChildCVC
      let cellPath = dataArr[indexPath.row]

        BookingDetails.selectedIndex = indexPath.row

        
        BookingDetails.camp_Duration = cell.durationLbl.text!
        BookingDetails.age_Group = "Children"
        BookingDetails.price = cell.priceLbl.text!.fiterPrice()
        BookingDetails.package_name = cell.titleLbl.text!
        
        
        ItineraryDetails.image = cell.IMGView.image!.toString()!

        ItineraryDetails.title = cell.titleLbl.text!
        
        ItineraryDetails.season_Name = cellPath.package_season_name
        ItineraryDetails.age_Group = cellPath.age_group
       
        switch indexPath.item {
        case 0:
        ItineraryDetails.itinerary_ID = "10"
        BookingDetails.package_id = "6"

        case 1:
        ItineraryDetails.itinerary_ID = "11"
        BookingDetails.package_id = "7"
        
        case 2:
        ItineraryDetails.itinerary_ID = "12"
        BookingDetails.package_id = "8"

        case 3:
        ItineraryDetails.itinerary_ID = "13"
        BookingDetails.package_id = "9"

        case 4:
        ItineraryDetails.itinerary_ID = "14"
        BookingDetails.package_id = "10"

        default:
                break
        
        }
        print("itinerary_Id = \(ItineraryDetails.itinerary_ID)")
        print("Package_Id = \(BookingDetails.package_id)")


        
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PackageDetailsVC") as! PackageDetailsVC
        self.parentContainerViewController()?.navigationController?.pushViewController(VC, animated: true)
        
    }

    

}
