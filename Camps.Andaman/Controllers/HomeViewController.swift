//
//  HomeViewController.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 22/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    @IBOutlet weak var offerCV: UICollectionView!
    
    @IBOutlet weak var partner_CV: UICollectionView!
    @IBOutlet weak var camping_CV: UICollectionView!
    @IBOutlet weak var gesture_CV: UICollectionView!
    
    @IBOutlet weak var activity_CV: UICollectionView!
    @IBOutlet weak var child_CV: UICollectionView!
    @IBOutlet weak var adult_CV: UICollectionView!
    @IBOutlet weak var subView: UIView!
    var adultData_Arr:PackageResponse = []
    var childData_Arr:PackageResponse = []

    var activityData_Arr:ActivityResponse = []
    var gestureData_Arr:GestureResonse = []
    var campingData_Arr:CampingListResponse = []
    var partners_Img_Arr = ["partner1","klm","tbo", "partner4", "partner5", "thai" , "AATA2"]

    let title_Array = ["It's time to start your adventures","Wild nature,safe adventure" ,"Bon-Fire" , "Sand Art", "Beach Yoga" ]
   
   var timer = Timer()
   var counter = 0
    
    var img_Arr:[String] = ["adventure","wildLife", "bon_Fire","sand", "Yoga"]
    let campingIMGUrl = "https://camps.goexploreandaman.com/assets/img/camping/"
    let gestureIMGUrl = "https://camps.goexploreandaman.com/assets/img/gesture/"
    let IMG_Url = "https://camps.goexploreandaman.com/assets/images/photo/"

    @IBOutlet weak var child_TitleLbl: UILabel!
    @IBOutlet weak var partnet_Title_Lbl: UILabel!
    @IBOutlet weak var camping_Title_Lbl: UILabel!
    @IBOutlet weak var geture_Title_Lbl: UILabel!
    @IBOutlet weak var activity_Title_Lbl: UILabel!
    @IBOutlet weak var adultTitle_Lbl: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
       
        checkInternet()

        CVChanges()
        
    }
    
   
    func CVChanges() {
       
        let cellSize = CGSize(width: self.view.frame.size.width - 20, height:170)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        offerCV.setCollectionViewLayout(layout, animated: true)
        offerCV.delegate = self
        offerCV.dataSource = self
        offerCV.reloadData()
        getPackagesData()
        getActivitiesData()
        getCampingData()
        getGestureData()
        allCVChanges()

        adultTitle_Lbl.makeRound()
        child_TitleLbl.makeRound()
        activity_Title_Lbl.makeRound()
        camping_Title_Lbl.makeRound()
        geture_Title_Lbl.makeRound()

        
       
        
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func changeImage() {
    
    if counter < title_Array.count {
        let index = IndexPath.init(item: counter, section: 0)
        self.offerCV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        counter += 1
    } else {
        counter = 0
        let index = IndexPath.init(item: counter, section: 0)
        self.offerCV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        counter = 1
    }
        
    }
    
    
    @IBAction func offerBtn_Axn(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "OffersVC") as! OffersVC
        DashboardVariables.isDashboard = false

        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func menu_Axn(_ sender: UIButton) {
        
    }
    
    func allCVChanges() {
      
        let cellSize = CGSize(width: 150 , height:150)
        let  partnercellSize = CGSize(width:120 , height:80)
        let  activitycellSize = CGSize(width:220 , height:150)

        let adultlayout = UICollectionViewFlowLayout()
        let childlayout = UICollectionViewFlowLayout()
        let activitylayout = UICollectionViewFlowLayout()
        let gesturelayout = UICollectionViewFlowLayout()
        let campinglayout = UICollectionViewFlowLayout()
       let partnerlayout = UICollectionViewFlowLayout()

        adultlayout.scrollDirection = .horizontal //.horizontal
        childlayout.scrollDirection = .horizontal //.horizontal
        activitylayout.scrollDirection = .horizontal //.horizontal
        gesturelayout.scrollDirection = .horizontal //.horizontal
        campinglayout.scrollDirection = .horizontal //.horizontal
        partnerlayout.scrollDirection = .horizontal //.horizontal
       
        adultlayout.itemSize = cellSize
        adultlayout.minimumLineSpacing = 10.0
        adultlayout.minimumInteritemSpacing = 1.0
       
        childlayout.itemSize = cellSize
        childlayout.minimumLineSpacing = 10.0
        childlayout.minimumInteritemSpacing = 1.0
    
        gesturelayout.itemSize = cellSize
        gesturelayout.minimumLineSpacing = 10.0
        gesturelayout.minimumInteritemSpacing = 1.0
     
        campinglayout.itemSize = cellSize
        campinglayout.minimumLineSpacing = 10.0
        campinglayout.minimumInteritemSpacing = 1.0
      
        activitylayout.itemSize = activitycellSize
        activitylayout.minimumLineSpacing = 10.0
        activitylayout.minimumInteritemSpacing = 1.0
        
        partnerlayout.itemSize = partnercellSize
        partnerlayout.minimumLineSpacing = 10.0
        partnerlayout.minimumInteritemSpacing = 10.0
        adult_CV.setCollectionViewLayout(adultlayout, animated: true)
        adult_CV.delegate = self
        adult_CV.dataSource = self
      
        child_CV.setCollectionViewLayout(childlayout, animated: true)
        child_CV.delegate = self
        child_CV.dataSource = self
        child_CV.showsHorizontalScrollIndicator = false
      
        activity_CV.setCollectionViewLayout(activitylayout, animated: true)
        activity_CV.delegate = self
        activity_CV.dataSource = self
        activity_CV.showsHorizontalScrollIndicator = false

        camping_CV.setCollectionViewLayout(campinglayout, animated: true)
        camping_CV.delegate = self
        camping_CV.dataSource = self
        camping_CV.showsHorizontalScrollIndicator = false
       
        partner_CV.setCollectionViewLayout(partnerlayout, animated: true)
        partner_CV.delegate = self
        partner_CV.dataSource = self
        partner_CV.showsHorizontalScrollIndicator = false
     
        gesture_CV.setCollectionViewLayout(gesturelayout, animated: true)
        gesture_CV.delegate = self
        gesture_CV.dataSource = self
        gesture_CV.showsHorizontalScrollIndicator = false
       

      
    }
   
    
    
    func getPackagesData()  {
        if reach.isConnectedToNetwork() == true {
    
            self.view.showActivityIndicator()
        ApiService.callPostToken(url: ClientInterface.packagesUrl, params: "", methodType: "GET", tag: "Packages", finish:finishPost)

       } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

        }
    }
    
    func getActivitiesData()  {
        if reach.isConnectedToNetwork() == true {
            self.view.showActivityIndicator()
        ApiService.callPostToken(url: ClientInterface.activitiesUrl, params: "", methodType: "GET", tag: "Activity", finish:finishPost)

       } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

        }
    }
    func getGestureData()  {
        if reach.isConnectedToNetwork() == true {
            self.view.showActivityIndicator()
        ApiService.callPostToken(url: ClientInterface.gesturesUrl, params: "", methodType: "GET", tag: "Gesture", finish:finishPost)

       } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

        }
    }
    
    func getCampingData()  {
        if reach.isConnectedToNetwork() == true {
            self.view.showActivityIndicator()
        ApiService.callPostToken(url: ClientInterface.campingUrl, params: "", methodType: "GET", tag: "Camping", finish:finishPost)

       } else {
        popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

        }
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {


        self.view.hideActivityIndicator()

        if  tag == "Activity" {
            
            do {

            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(ActivityResponse.self, from: jsonData)

            print(parsedData)

            if parsedData.isEmpty == false {
                activityData_Arr = parsedData

            }
            
            activity_CV.isHidden = false
            activity_CV.reloadData()

            }
            } catch {
               print("Parse Error: \(error)")

            }
            
        } else if tag == "Gesture" {
           
            do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(GestureResonse.self, from: jsonData)

                print(parsedData)

            if parsedData.isEmpty == false {
                gestureData_Arr = parsedData
                    
            }
            gesture_CV.isHidden = false
            gesture_CV.reloadData()

            }
              
            } catch {
               print("Parse Error: \(error)")

            }
        } else if tag == "Camping" {
        
            do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(CampingListResponse.self, from: jsonData)
            print(parsedData)
            
            if parsedData.isEmpty == false {
                campingData_Arr = parsedData
            }
                
                camping_CV.isHidden = false

                camping_CV.reloadData()


            }
            } catch {
               print("Parse Error: \(error)")

            }

        } else {
            do {
           
                if let jsonData = data {
                let parsedData = try JSONDecoder().decode(PackageResponse.self, from: jsonData)
                print(parsedData)
                
                if parsedData.isEmpty == false {
                    for adultData in parsedData {
                        if adultData.age_group == "adult" {
                            adultData_Arr.append(adultData)

                        } else {
                            childData_Arr.append(adultData)
                        }
                    }
                    adult_CV.isHidden = false
                    child_CV.isHidden = false
                    adult_CV.reloadData()
                    child_CV.reloadData()
                
                } else {
                    popUpAlert(title: "Alert", message: "No Packeges Data", action: .alert)
                }
               
                }
   
            } catch {
             print("Parse Error: \(error)")
                
            }
        }
        
    }

   
   
}
extension HomeViewController :  GestureDelegate,  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func onGestureItemTapped() {
        print("cellTapped")
    }
    
    
    
    
//    MARK:- Offers Collectionview Data
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == adult_CV {
            return adultData_Arr.count

        } else if  collectionView == child_CV  {
            return childData_Arr.count

        } else if collectionView == activity_CV {
            return activityData_Arr.count

        } else if collectionView == gesture_CV {
            return gestureData_Arr.count

        } else if collectionView == camping_CV {
            return campingData_Arr.count

        } else if collectionView == partner_CV  {
            return partners_Img_Arr.count

        } else {
            return title_Array.count

        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = offerCV.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath) as! OffersCVCell
        let adultCell = adult_CV.dequeueReusableCell(withReuseIdentifier: "AdultCell", for: indexPath) as! HomeCVC
        let childCell = child_CV.dequeueReusableCell(withReuseIdentifier: "ChildCell", for: indexPath) as! ChildCVC
        
        let activityCell = activity_CV.dequeueReusableCell(withReuseIdentifier: "ActivitiesCell", for: indexPath) as! ActivitiesCVC

        let gestureCell = gesture_CV.dequeueReusableCell(withReuseIdentifier: "GestureCell", for: indexPath) as! GestureCVC
        let campingCell = camping_CV.dequeueReusableCell(withReuseIdentifier: "CampingCell", for: indexPath) as! CampingCVC
        let partnerCell = partner_CV.dequeueReusableCell(withReuseIdentifier: "PartnersCell", for: indexPath) as! PartnersCVC
        
        
        
        if collectionView == adult_CV {
           
            let cellPath = adultData_Arr[indexPath.row]
            
            if cellPath.age_group == "adult" {
                adultCell.titleLbl.text = cellPath.package_title
                adultCell.durationLbl.text = cellPath.package_description
                adultCell.priceLbl.text = "₹ \(cellPath.package_price)"
                adultCell.IMGView.setImage(urlStr: IMG_Url + cellPath.package_image_name)
            }
            
           
            adultCell.IMGView.layer.cornerRadius = 10
            
            return adultCell
      
        } else if  collectionView == child_CV  {
        
          
            let cellPath = childData_Arr[indexPath.row]

            if cellPath.age_group == "children" {
                childCell.titleLbl.text = cellPath.package_title
                childCell.durationLbl.text = cellPath.package_description
                childCell.priceLbl.text = "₹ \(cellPath.package_price)"
                childCell.IMGView.setImage(urlStr: IMG_Url + cellPath.package_image_name)
            }
            
            childCell.IMGView.layer.cornerRadius = 10
                
            return childCell
        
        
        } else if collectionView == activity_CV {
        
           
            let cellPath = activityData_Arr[indexPath.row]
            activityCell.titleLbl.text = cellPath.activityName
            activityCell.IMGView.setImage(urlStr: ClientConfig.Activity_ImgUrl + cellPath.activityImageLink)
            activityCell.IMGView.layer.cornerRadius = 10
            
            return activityCell
       
        } else if collectionView == gesture_CV {
            
          
            let cellPath = gestureData_Arr[indexPath.row]
            gestureCell.titleLbl.text = cellPath.gestureName
            gestureCell.IMGView.setImage(urlStr: gestureIMGUrl + cellPath.gestureImageLinkFirst)
                    

            gestureCell.IMGView.makeRounded()
                
            
            return gestureCell
            
        } else if collectionView == camping_CV {
           
           
            let cellPath = campingData_Arr[indexPath.row]
            
            campingCell.titleLbl.text = cellPath.campingName
            campingCell.IMGView.setImage(urlStr: campingIMGUrl + cellPath.campingImageLinkFirst)
            campingCell.IMGView.makeRounded()
                    
                
                return campingCell
       
        } else if collectionView == partner_CV  {
         
            partnerCell.IMG_View.image = UIImage(named: "\(partners_Img_Arr[indexPath.row])")
            
            partnerCell.IMG_View.layer.cornerRadius = 10
            partnerCell.IMG_View.layer.masksToBounds = true
          
            return partnerCell
      
        } else {
          
          
            
            cell.titleLbl.text = title_Array[indexPath.row]
            cell.Img_View.image = UIImage(named: "\(img_Arr[indexPath.row])")
            cell.myPage.currentPage = indexPath.item
            cell.myPage.numberOfPages = title_Array.count
            cell.blurView.layer.cornerRadius = 10
            cell.Img_View.layer.cornerRadius = 10
            
            return cell
        
        }
        
        
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == adult_CV {
            let cell = collectionView.cellForItem(at: indexPath) as! HomeCVC

            let cellPath = adultData_Arr[indexPath.row]

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
            self.navigationController?.pushViewController(VC, animated: true)
            
          
        } else if  collectionView == child_CV  {
            let cell = collectionView.cellForItem(at: indexPath) as! ChildCVC
            let cellPath = childData_Arr[indexPath.row]

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
            self.navigationController?.pushViewController(VC, animated: true)
            
        } else if collectionView == activity_CV {
           
            let cellPath = activityData_Arr[indexPath.row]
           
           ActivityVariables.locTitle = cellPath.activityName
           ActivityVariables.locIMG = cellPath.activityImageLink
           ActivityVariables.locDescription = cellPath.activityDescription

           let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CampingVC") as! CampingVC

           self.navigationController?.pushViewController(VC, animated: true)
           
    
        } else if collectionView == gesture_CV {
            let cellPath = gestureData_Arr[indexPath.row]

            GestureVariables.selected_Id = cellPath.gestureID
            
            
            
            GestureVariables.isGesture = true
            GestureVariables.selected_Id = cellPath.gestureID
            
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GestureVC") as! GestureVC

            self.navigationController?.pushViewController(VC, animated: true)

        } else if collectionView == camping_CV {
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GestureVC") as! GestureVC
          
            let cellPath = campingData_Arr[indexPath.row]

            GestureVariables.isGesture = false
            GestureVariables.selected_Id = cellPath.campingID
            
            self.navigationController?.pushViewController(VC, animated: true)

        } else {
            print("Other CV")
        }
        
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellSize = CGSize(width: 150, height: 150)
//        let activityCellSize = CGSize(width: 220, height: 150)
//        let partnetCellSize = CGSize(width: 80, height: 110)
//
//        if collectionView == partner_CV {
//            return partnetCellSize
//        } else if collectionView == activity_CV {
//            return activityCellSize
//
//        } else if collectionView == offerCV {
//            let offerCellSize = CGSize(width:offerCV.frame.size.width, height:offerCV.frame.size.height)
//
//            return offerCellSize
//        } else {
//          return  cellSize
//        }
//    }
    
   
   
    
//    func onGestureItemTapped() {
//        let VC = self.storyboard?.instantiateViewController(identifier: "GestureVC") as! GestureVC
//        self.navigationController?.pushViewController(VC, animated: true)
//    }
//
//
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 6
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//       if indexPath.section == 1 {
//       let childCell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as! ChildTVC
//        return childCell
//
//       } else if  indexPath.section == 2 {
//        let activityCell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivitiesTVC
//        activityCell.delegate = self
//        return activityCell
//
//      } else if indexPath.section == 3 {
//        let gestureCell = tableView.dequeueReusableCell(withIdentifier: "GestureCell", for: indexPath) as! GesturesTVC
//        return gestureCell
//
//     } else if indexPath.section == 4{
//       let campingCell = tableView.dequeueReusableCell(withIdentifier: "CampingCell", for: indexPath) as! CampingTVC
//        return campingCell
//
//     } else if indexPath.section == 5 {
//
//        let parntersCell = tableView.dequeueReusableCell(withIdentifier: "PartnersCell", for: indexPath) as! PartnersTVC
//
//        return parntersCell
//
//    } else {
//      let adultCell = tableView.dequeueReusableCell(withIdentifier: "AdultCell", for: indexPath) as! AdultTVC
//      return adultCell
//     }
//
//
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 5 {
//        return 100
//        } else {
//        return 180
//        }
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: dataTV.frame.width , height: 25))
//         returnedView.backgroundColor = .baseColor
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: returnedView.frame.width, height: returnedView.frame.height))
//        label.textColor = .white
//        label.backgroundColor = .clear
//        label.textAlignment = .center
//        label.font = UIFont(name: "Optima", size: 15)
//        label.layer.cornerRadius = 10
//        returnedView.layer.cornerRadius = 10
//
//       switch section {
//
//        case 0:
//        label.text = "Camp Packages [Adult - (18 - 35 years)]"
//
//        case 1:
//        label.text = "Camp Packages [Child - (14 - 18 years)]"
//
//        case 2:
//        label.text = "Camp Activity"
//
//        case 3 :
//        label.text = "Gesture"
//
//        case 4:
//        label.text = "Camp Locations"
//
//        case 5:
//        returnedView.backgroundColor = .clear
//        label.textColor = .white
//        label.text = "Our Partners"
//
//        default:
//        label.text = ""
//
//        }
//
//        returnedView.addSubview(label)
//
//
//
//        return returnedView
//
//    }
//
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if indexPath.section == 0 {
//        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PackageDetailsVC") as! PackageDetailsVC
//        self.navigationController?.pushViewController(VC, animated: true)
//        print("TV0")
//        }
//
//   }
    
    
    
    
    
    
    
}



