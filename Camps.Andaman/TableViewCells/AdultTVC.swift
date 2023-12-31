//
//  AdultTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 26/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class AdultTVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

   weak var delegate:CampsDelegate?

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

       

        let cellSize = CGSize(width: 150 , height:dataCV.frame.height)
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
        ApiService.callPostToken(url: ClientInterface.packagesUrl, params: "", methodType: "GET", tag: "Adult", finish:finishPost)

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
                        if adultData.age_group == "adult" {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdultCell", for: indexPath) as! HomeCVC

        let cellPath = dataArr[indexPath.row]
        
        if cellPath.age_group == "adult" {
            cell.titleLbl.text = cellPath.package_title
            cell.durationLbl.text = cellPath.package_description
            cell.priceLbl.text = "₹ \(cellPath.package_price)"
            cell.IMGView.setImage(urlStr: IMG_Url + cellPath.package_image_name)
        }
        
       
        cell.IMGView.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HomeCVC

        let cellPath = dataArr[indexPath.row]

        BookingDetails.selectedIndex = indexPath.row
        BookingDetails.camp_Duration = cell.durationLbl.text!

        BookingDetails.age_Group = "Adult"
        BookingDetails.price = cell.priceLbl.text!.fiterPrice()
        BookingDetails.package_name = cell.titleLbl.text!
       
        ItineraryDetails.image = cell.IMGView.image!.toString()!
        ItineraryDetails.title = cell.titleLbl.text!
        
        ItineraryDetails.season_Name = cellPath.package_season_name
        ItineraryDetails.age_Group = cellPath.age_group
             
        
        switch indexPath.item {
        case 0:
            ItineraryDetails.itinerary_ID = "15"

            BookingDetails.package_id = "1"
        case 1:
                ItineraryDetails.itinerary_ID = "16"
            BookingDetails.package_id = "2"

        case 2:
                ItineraryDetails.itinerary_ID = "17"
            BookingDetails.package_id = "3"

        case 3:
                ItineraryDetails.itinerary_ID = "18"
            BookingDetails.package_id = "4"

        case 4:
                ItineraryDetails.itinerary_ID = "19"
            BookingDetails.package_id = "5"

        default:
            break
        }
        print("itinerary_Id = \(ItineraryDetails.itinerary_ID)")
        print("packageID = \(BookingDetails.package_id)")

        
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PackageDetailsVC") as! PackageDetailsVC
        self.parentContainerViewController()?.navigationController?.pushViewController(VC, animated: true)
        
      
        
    }
    
    
   
    
   
}
