//
//  AboutTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 18/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class AboutTVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    let imageArr = ["dev","anita","Binoy","anuj"]
    let titleArr = ["DEV KUMAR","ANITHA BISWAS","BINOY","ANUJ JOHN"]
    let subTitleArr = ["CEO & FOUNDER","DIRECTOR","DIRECTOR OF OPERATIONS","REGIONAL INCHARGE"]
    
    @IBOutlet weak var dataCV: UICollectionView!
    
    var dataArr:AboutResponse = []
    weak var delegate:DetailsDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        CVChanges()
    }

  
    func CVChanges() {
    
        dataCV.isHidden = true
        getData()
        let cellSize = CGSize(width:150 , height:200)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 1)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 1.0
        dataCV.setCollectionViewLayout(layout, animated: true)
        dataCV.delegate = self
        dataCV.dataSource = self
        dataCV.reloadData()
        dataCV.showsHorizontalScrollIndicator = false
      
  }
    
    func getData()  {
        
        if reach.isConnectedToNetwork() == true {
            self.contentView.showActivityIndicator()
        ApiService.callPostToken(url: ClientInterface.membersUrl, params: "", methodType: "GET", tag: "Aboutus", finish:finishPost)
        } else {
        self.contentView.makeToast("Check Internet connection")
        }
        
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        
        self.contentView.hideActivityIndicator()
        
        do {
            if let jsonData = data {
            let parsedData = try JSONDecoder().decode(AboutResponse.self, from: jsonData)
            print(parsedData)
            
            dataArr = parsedData
            print("dataArr = \(dataArr)")
            dataCV.isHidden = false
            dataCV.reloadData()
            
            } else {
            self.contentView.makeToast("Error in Connecting Server..Try Again.")
            }
            
        } catch {
        self.contentView.makeToast("Error in Connecting Server..Try Again.")
        print("Parse Error: \(error)")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AboutCVC
        let cellPath = dataArr[indexPath.row]
        cell.IMGView.setImage(urlStr: ClientConfig.membersImgUrl + cellPath.memberImageName)
        cell.titleLBl.text = cellPath.memberTitle + " " + cellPath.memberName
        cell.subTitleLbl.text = cellPath.memberDesignation
        cell.desc_Lbl.text = cellPath.memberDescription
        cell.fb_linkLbl.text = cellPath.facebookProfileLink
        cell.Lnk_Lbl.text = cellPath.linkedinProfileLink
        cell.twt_lbl.text = cellPath.twitterProfileLink
        cell.IMGView.makeRounded()

        
//        cell.IMGView.image = UIImage(named: "\(imageArr[indexPath.row])")
//        
//        cell.titleLBl.text = titleArr[indexPath.row]
//        cell.subTitleLbl.text = subTitleArr[indexPath.row]
//        
        return cell
        
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currenctCell = collectionView.cellForItem(at: indexPath) as! AboutCVC
        print("currenctCell = \(currenctCell.titleLBl.text!)")
        
        PersonDetails.description = currenctCell.desc_Lbl.text!
        PersonDetails.name =  currenctCell.titleLBl.text!
        let imgStr = currenctCell.IMGView.image!.toString()!
        PersonDetails.img = imgStr

        PersonDetails.designation = currenctCell.subTitleLbl.text!
        
        PersonDetails.links = [currenctCell.fb_linkLbl.text! , currenctCell.twt_lbl.text!, currenctCell.Lnk_Lbl.text!]
        print("links = \(PersonDetails.links)")
        
        if delegate != nil {
            delegate?.onIndexTapped()
        }
                }
}
