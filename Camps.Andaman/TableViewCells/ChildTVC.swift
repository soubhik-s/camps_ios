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
  
    var title_Arr:[String] = []
    var img_Arr:[String] = []
    var price_Arr:[String] = []
    var duration_Arr:[String] = []
    weak var delegate:CampsDelegate?


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


        dataArr = parsedData
        print("Child Arr = \(dataArr)")
        for adultData in dataArr {
        if adultData.age_group == "children" {
        title_Arr.append(adultData.package_title)
        print("Childtitle_Arr = \(title_Arr)")

            let imgUrlStr = ClientConfig.Imgae_Url  + adultData.package_image_name
        img_Arr.append(imgUrlStr)
        print("ChildimgArr = \(img_Arr)")
        price_Arr.append(adultData.package_price)
        print("Childprice_Arr = \(price_Arr)")
        duration_Arr.append(adultData.package_description)
        print("Childduration_Arr = \(duration_Arr)")
        }
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
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChildCell", for: indexPath) as! ChildCVC
            cell.titleLbl.text = title_Arr[indexPath.row]
            cell.durationLbl.text = duration_Arr[indexPath.row]
            cell.priceLbl.text = "Rs - \(price_Arr[indexPath.row])"
            cell.IMGView.setImage(urlStr: img_Arr[indexPath.row])
            cell.IMGView.layer.cornerRadius = 10
            
            return cell
        }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ChildCVC
      
        BookingDetails.selectedIndex = indexPath.row

        
        BookingDetails.camp_Duration = cell.durationLbl.text!
        BookingDetails.age_Group = "Children"
        BookingDetails.price = cell.priceLbl.text!.fiterPrice()
        BookingDetails.package_name = cell.titleLbl.text!
        
        
        ItineraryDetails.image = cell.IMGView.image!.toString()!

        ItineraryDetails.title = cell.titleLbl.text!
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

//        self.onDidSelectItem?(indexPath)

        
        if delegate != nil {
        delegate?.cellTapped()
        }
        
    }

    

}
