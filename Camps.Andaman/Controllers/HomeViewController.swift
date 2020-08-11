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
    
    var dataArr:OffersResponse = []
    @IBOutlet weak var offerCV: UICollectionView!
    
    
    @IBOutlet weak var dataTV: UITableView!
    @IBOutlet weak var subView: UIView!
    
    let title_Array = ["It's time to start your adventures","Wild nature,safe adventure"]
    let subTitle_Arr = ["Set the target and prepare yourself to experience your dream adventurous activities. ","A friendly associate with knowledge on every corners of the Andaman Islands."]
    var timer = Timer()
    var counter = 0


    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewChanges()
        
    }
    
    func viewChanges() {
    
        dataTV.reloadData()
        CVChanges()
        
    }
    func CVChanges() {
        getData()
        let cellSize = CGSize(width:offerCV.frame.size.width, height:offerCV.frame.size.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        offerCV.setCollectionViewLayout(layout, animated: true)
        offerCV.delegate = self
        offerCV.dataSource = self
        offerCV.reloadData()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func changeImage() {
    
    if counter < dataArr.count {
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
    
    
    
    @IBAction func menu_Axn(_ sender: UIButton) {
        
    }
    
    
     func getData()  {
           
        if reach.isConnectedToNetwork() == true {
       
        offerCV.showActivityIndicator()
        ApiService.callPostToken(url: ClientInterface.offersUrl, params: "", methodType: "GET", tag: "Offer", finish:finishPost)

        } else {
        self.view.makeToast("Check Internet Connection")
            
        }
       }
   
    func finishPost (message:String, data:Data? , tag: String) -> Void {

        offerCV.hideActivityIndicator()

        do {

        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(OffersResponse.self, from: jsonData)
            print(parsedData)
            dataArr = parsedData
            offerCV.reloadData()
        } else {
        popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
        }
        } catch {
        popUpAlert(title: "Alert", message: "Error_Cheeck Details", action: .alert)
        print("Parse Error: \(error)")
        }



    }
    
   
   
}
extension HomeViewController : UITableViewDelegate, UITableViewDataSource, CampsDelegate, GestureDelegate, CampingDelegate, UICollectionViewDelegate , UICollectionViewDataSource {
    
//    MARK:- Offers Collectionview Data
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath) as! OffersCVCell
        
        let cellPath = dataArr[indexPath.row]
        cell.contentView.frame  = offerCV.frame
        cell.Img_View.setImage(urlStr: ClientConfig.offerIMGUrl + cellPath.offersImageName)
        cell.myPage.numberOfPages = dataArr.count
        cell.myPage.currentPage = indexPath.row
        cell.offerCode_Lbl.text = cellPath.couponCode

        cell.discount_Lbl.text = "\(cellPath.discountOffers) %"
       
        return cell
    
    }
    
    
    
    func cellTapped() {
        print("CellTapped")
        let VC = self.storyboard?.instantiateViewController(identifier: "PackageDetailsVC") as! PackageDetailsVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func onGestureItemTapped() {
        let VC = self.storyboard?.instantiateViewController(identifier: "GestureVC") as! GestureVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func onItemTapped() {
        let VC = self.storyboard?.instantiateViewController(identifier: "CampingVC") as! CampingVC
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if indexPath.section == 1 {
       let childCell = tableView.dequeueReusableCell(withIdentifier: "ChildCell", for: indexPath) as! ChildTVC
        childCell.delegate = self
        return childCell
        
       } else if  indexPath.section == 2 {
        let activityCell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivitiesTVC
        activityCell.delegate = self
        return activityCell
        
      } else if indexPath.section == 3 {
        let gestureCell = tableView.dequeueReusableCell(withIdentifier: "GestureCell", for: indexPath) as! GesturesTVC
        gestureCell.delegate = self
        return gestureCell
        
     } else if indexPath.section == 4{
       let campingCell = tableView.dequeueReusableCell(withIdentifier: "CampingCell", for: indexPath) as! CampingTVC
        campingCell.delegate = self
        return campingCell
            
     } else if indexPath.section == 5 {
       let parntersCell = tableView.dequeueReusableCell(withIdentifier: "PartnersCell", for: indexPath) as! PartnersTVC
       return parntersCell
            
     } else {
      let adultCell = tableView.dequeueReusableCell(withIdentifier: "AdultCell", for: indexPath) as! AdultTVC
      adultCell.delegate = self
      return adultCell
     }
  
   }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 5 {
        return 70
        } else {
        return 150
        }
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: dataTV.frame.width , height: 25))
         returnedView.backgroundColor = .baseColor
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: returnedView.frame.width, height: returnedView.frame.height))
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont(name: "Optima", size: 15)
        label.layer.cornerRadius = 10
        returnedView.layer.cornerRadius = 10

       switch section {
        
        case 0:
        label.text = "Camp Packages [Adult - (18 - 35 years)]"

        case 1:
        label.text = "Camp Packages [Child - (14 - 18 years)]"

        case 2:
        label.text = "Camp Activity"

        case 3 :
        label.text = "Gesture"
        
        case 4:
        label.text = "Camp Locations"

        case 5:
        returnedView.backgroundColor = .clear
        label.textColor = .white
        label.text = "Our Partners"
        
        default:
        label.text = ""

        }
        
        returnedView.addSubview(label)
            
    

        return returnedView
        
    }
    
   
           
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.section == 0 {
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PackageDetailsVC") as! PackageDetailsVC
        self.navigationController?.pushViewController(VC, animated: true)
        print("TV0")
        }
          
   }
    
    
    
    
    
    
    
}



