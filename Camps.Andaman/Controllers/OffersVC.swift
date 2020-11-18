//
//  OffersVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 30/10/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class OffersVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
   

   var dataArr:OffersResponse = []
    
    @IBOutlet weak var offersCV: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CVChanges()
        getData()
    }
    
    func CVChanges() {
        let cellSize = CGSize(width:offersCV.frame.size.width, height:200)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        offersCV.setCollectionViewLayout(layout, animated: true)
        offersCV.delegate = self
        offersCV.dataSource = self
        offersCV.reloadData()
        
        print("Status = \(DashboardVariables.isDashboard)")
        
    }
    
    
    @IBAction func back_Btn_Axn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getData()  {
            
         if reach.isConnectedToNetwork() == true {
        
         self.showActivityIndicator()
         ApiService.callPostToken(url: ClientInterface.offersUrl, params: "", methodType: "GET", tag: "Offer", finish:finishPost)

         } else {
         self.view.makeToast("Check Internet Connection")
             
         }
       
     }
    
     func finishPost (message:String, data:Data? , tag: String) -> Void {

         self.hideActivityIndicator()

         do {

         if let jsonData = data {
         let parsedData = try JSONDecoder().decode(OffersResponse.self, from: jsonData)
             print(parsedData)
             
             if parsedData.isEmpty == false {
                
                for offerData in parsedData {
                
                    if DashboardVariables.isDashboard == true {
                        if offerData.discountType == "others" {

                            dataArr.append(offerData)

                        }
                    
                    } else {
                        if offerData.status == "active" {
                                
                            dataArr.append(offerData)
                        
                                
                        }
                    }
                    
                    print("OfferdataArr = \(dataArr)")

                 
                }
                 

                if dataArr.isEmpty == false {
                    offersCV.isHidden = false

                    offersCV.reloadData()

                } else {
                    popUpAlert(title: "Alert", message: "No Active Offers ", action: .alert)
                }
                
                
             }
         }
         } catch {
         print("Parse Error: \(error)")
         }



     }
    
//    MARK:- Offers Collectionview Data
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataArr.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath) as! OffersCVCell
    
    let cellPath = dataArr[indexPath.row]
    if cellPath.discountType == "others" {
    cell.Img_View.setImage(urlStr: ClientConfig.offerIMGUrl + cellPath.offersImageName)
        cell.myPage.isHidden = true
    cell.myPage.numberOfPages = dataArr.count
    cell.myPage.currentPage = indexPath.row
    cell.offerCode_Lbl.text = "Code : \(cellPath.couponCode)"
    cell.titleLbl.text = cellPath.couponName
    cell.expiryLbl.text = "Expires  : \(cellPath.validTo)"
    cell.discount_Lbl.text = "Discount : \(cellPath.discountOffers) %"
    cell.Img_View.layer.cornerRadius = 10
    
    }
    
    return cell

}
       
}
