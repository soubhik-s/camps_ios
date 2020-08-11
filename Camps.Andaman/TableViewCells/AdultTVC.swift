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
    var img_Arr:[String]  = []
    var title_Arr:[String] = []
    var price_Arr:[String] = []
    var duration_Arr:[String] = []

    var isConnected:Bool = false
    
    var title_Arr2 = ["SUMMER","SPRING","PRE-WINTER","WINTER","AUTUMN",]
    var img_Arr2 = ["summer","spring","prewinter","winter","autumn"]
//    var onDidSelectItem: ((IndexPath) -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        CVChanges()
    }
    
    func CVChanges() {
        dataCV.isHidden = true
        getData()
//        if CampVariables.isConnected == false {
//            print("ISConnected = \(CampVariables.isConnected)")
//            getData()
//        dataCV.isHidden = true
//
//        } else {
//        print("Connected")
//        }
       

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


            dataArr = parsedData
            print("dataARr = \(dataArr)")
            for adultData in dataArr {
                if adultData.age_group == "adult" {
            title_Arr.append(adultData.package_title)
               print("Adult_Arr = \(title_Arr)")

            let imgUrlStr = "https://camps.goexploreandaman.com/assets/images/photo/" + adultData.package_image_name
            img_Arr.append(imgUrlStr)
            print("AdultimgArr = \(img_Arr)")
            price_Arr.append(adultData.package_price)

            print("Adultprice_Arr = \(price_Arr)")
            duration_Arr.append(adultData.package_description)
            print("Adultduration_Arr = \(duration_Arr)")



            }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdultCell", for: indexPath) as! HomeCVC

        cell.titleLbl.text = title_Arr[indexPath.row]
        cell.IMGView.setImage(urlStr: img_Arr[indexPath.row])
        cell.priceLbl.text = "Rs- \(price_Arr[indexPath.row]) /-"
        cell.durationLbl.text = duration_Arr[indexPath.row]
        
       
        cell.IMGView.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HomeCVC
//        CampVariables.hotelIndex = indexPath.row
//        CampVariables.campTitle = cell.titleLbl.text!
//        CampVariables.duration = cell.durationLbl.text!
//        CampVariables.price = cell.priceLbl.text!
//        print("Selectedindex = \(CampVariables.campTitle)")
//
        
        BookingDetails.selectedIndex = indexPath.row
        BookingDetails.camp_Duration = cell.durationLbl.text!

        BookingDetails.age_Group = "Adult"
        BookingDetails.price = cell.priceLbl.text!.fiterPrice()
        BookingDetails.package_name = cell.titleLbl.text!
       
        ItineraryDetails.image = cell.IMGView.image!.toString()!
        ItineraryDetails.title = cell.titleLbl.text!
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
//        getTopMostViewController()!.navigationController?.pushViewController(VC, animated: true)
           
//       self.onDidSelectItem?(indexPath)

        
        if delegate != nil {
        delegate?.cellTapped()
        }
        
    }
    
    
   
    
    func reConnect() {
        if isConnected == false {
    self.getData()
    } else {
    print("Connected")
    }
    }
}
