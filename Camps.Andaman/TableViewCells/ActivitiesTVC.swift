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
    
    
//   let title_Arr = ["FREEDOM FIGHTERS FAMILY","TREKKING","SCUBA DIVIVNG","LOCAL ARTISANS","PEARL CULTIVATION", "TRIBAL DANCE","MONUMENT VISIT","NIOT","BARREN ISLANDS","M.G NATIONAL PARK", "BIRD WATCHING"]
//
//
    let img_Arr2 = ["Freedom_fighters","Trekking","Scuba", "local_artisans","Pearl_farm","nicobari_dance","monuments","NIOT","BarrenIsland","MG_Nationalpark","Birdwatch","LifestyleCulture","QA"]


      var dataArr:ActivityResponse = []
//       var onDidSelectItem: ((IndexPath) -> ())?
    var img_Arr:[String]  = []
    var title_Arr:[String] = []
    var description_Arr:[String] = []

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

        dataArr = parsedData
        print("ActivityData = \(dataArr)")
        for adultData in dataArr {
        title_Arr.append(adultData.activityName)
        print("Actitvitytitle_Arr = \(title_Arr)")

            let imgUrlStr = ClientConfig.Activity_ImgUrl + adultData.activityImageLink
            img_Arr.append(adultData.activityImageLink)
        print("ActivityimgArr = \(img_Arr)")
            description_Arr.append(adultData.activityDescription)
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
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitiesCell", for: indexPath) as! ActivitiesCVC

        cell.titleLbl.text = title_Arr[indexPath.row]
       let Urlstr = ClientConfig.Activity_ImgUrl + img_Arr[indexPath.row]
//        cell.IMGView.image = UIImage(named: "\(img_Arr2[indexPath.row])")
        cell.IMGView.setImage(urlStr: Urlstr)
        cell.IMGView.layer.cornerRadius = 10
        cell.descriptionLbl.text = description_Arr[indexPath.row]
        
        return cell
        
    }
        

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ActivitiesCVC
        GestureVariables.Title = cell.titleLbl.text!
        GestureVariables.IMG = (cell.IMGView.image?.toString()!)!
        GestureVariables.Description = cell.descriptionLbl.text!
//        self.onDidSelectItem?(indexPath)

        
        if delegate != nil {
            delegate?.onGestureItemTapped()
        }
        
    }
}
