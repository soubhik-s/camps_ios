//
//  GestureVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 15/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class GestureVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    
    
    @IBOutlet weak var gestureCV: UICollectionView!
    @IBOutlet weak var gestureTV: UITableView!

    let gestureIMGUrl = "https://camps.goexploreandaman.com/assets/img/gesture/"
    let campinIMGUrl  = "https://camps.goexploreandaman.com/assets/img/camping/"
    var img_Arr:[String] = []
    var des_Arr:[String] = []
    var activity_Arr:[String] = []
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {
        gestureCV.isHidden = true
        gestureTV.isHidden = true
        gestureTV.sectionHeaderHeight = 30
        CVChanges()
      
        if GestureVariables.isGesture == true {
            getGestureData()

        } else {
            getCampingData()
        }
   
        DispatchQueue.main.async {
        
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            
        }
               
          
    }
           
        
    @objc func changeImage() {
           
    
        if counter < img_Arr.count {
        
            let index = IndexPath.init(item: counter, section: 0)
            
            self.gestureCV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
            counter += 1
           
        } else {
        
            counter = 0
               let index = IndexPath.init(item: counter, section: 0)
               self.gestureCV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               counter = 1
           }
               
    
    }
    
    
    func CVChanges() {
        let cellSize = CGSize(width:gestureCV.frame.width , height:gestureCV.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 1.0
        gestureCV.setCollectionViewLayout(layout, animated: true)
        gestureCV.delegate = self
        gestureCV.dataSource = self
        gestureCV.showsHorizontalScrollIndicator = false
            
        
    }
    
    func getCampingData()  {
            
        if reach.isConnectedToNetwork() == true {
            self.view.showActivityIndicator()
            ApiService.callPostToken(url: ClientInterface.campingUrl, params: "", methodType: "GET", tag: "Camping", finish:finishPost)

    
        } else {
            self.popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)
            
        }
           
    }
     func getGestureData()  {
         
        if reach.isConnectedToNetwork() == true {
            self.view.showActivityIndicator()
            ApiService.callPostToken(url: ClientInterface.gesturesUrl, params: "", methodType: "GET", tag: "Gesture", finish:finishPost)

           } else {
                self.popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

            }
        
    }

    
    func finishPost (message:String, data:Data? , tag: String) -> Void {

        self.view.hideActivityIndicator()

        if tag == "Camping"  {
              
        
            do {
                
                if let jsonData = data {
                    
                let parsedData = try JSONDecoder().decode(CampingListResponse.self, from: jsonData)

                print(parsedData)
                    
                for gesture_Data in parsedData {
                if GestureVariables.selected_Id == gesture_Data.campingID {
                               
                img_Arr.append(gesture_Data.campingImageLinkFirst)
                img_Arr.append(gesture_Data.campingImageLinkSecond)
                img_Arr.append(gesture_Data.campingImageLinkThird)
                img_Arr.append(gesture_Data.campingImageLinkFourth)
                    des_Arr.append(gesture_Data.campingDescriptionFirst.removeSpecialCharsFromString())
                    des_Arr.append(gesture_Data.campingDescriptionSecond.removeSpecialCharsFromString())
                    des_Arr.append(gesture_Data.campingDescriptionThird.removeSpecialCharsFromString())
                    des_Arr.append(gesture_Data.campingDescriptionFourth.removeSpecialCharsFromString())
                
                activity_Arr =  gesture_Data.campingActivity.components(separatedBy: "->")
                titleLbl.text = gesture_Data.campingName
                   
                    print("img_Arr = \(img_Arr)")
                    print("des_Arr = \(des_Arr)")
                    print("activity_Arr = \(activity_Arr)")


                img_Arr = img_Arr.filter({ $0 != ""})
                des_Arr = des_Arr.filter({ $0 != ""})
                activity_Arr = activity_Arr.filter({ $0 != ""})

                print("img_Arr = \(img_Arr)")
                print("des_Arr = \(des_Arr)")
                print("activity_Arr = \(activity_Arr)")


                    gestureCV.isHidden = false
                    gestureTV.isHidden = false

                    gestureCV.reloadData()
                    gestureTV.reloadWithAnimation()
                }
                            
                }

                }
                    
                  
                } catch {
                   print("Parse Error: \(error)")

                }
           
            
            } else {

            do {
            
            if let jsonData = data {
                
            let parsedData = try JSONDecoder().decode(GestureResonse.self, from: jsonData)

            print(parsedData)
                
            for gesture_Data in parsedData {
            if GestureVariables.selected_Id == gesture_Data.gestureID {
                           
                img_Arr.append(gesture_Data.gestureImageLinkFirst)
            img_Arr.append(gesture_Data.gestureImageLinkSecond)
            img_Arr.append(gesture_Data.gestureImageLinkThird)
            img_Arr.append(gesture_Data.gestureImageLinkFourth)
                des_Arr.append(gesture_Data.gestureDescriptionFirst.removeSpecialCharsFromString())
                des_Arr.append(gesture_Data.gestureDescriptionSecond.removeSpecialCharsFromString())
                des_Arr.append(gesture_Data.gestureDescriptionThird.removeSpecialCharsFromString())
                des_Arr.append(gesture_Data.gestureDescriptionFourth.removeSpecialCharsFromString())
              
                if gesture_Data.gestureActivity.isEmpty == false {
                    activity_Arr =  gesture_Data.gestureActivity.components(separatedBy: "->")

                }
            titleLbl.text = gesture_Data.gestureName
                print("img_Arr = \(img_Arr)")
                print("des_Arr = \(des_Arr)")
                print("activity_Arr = \(activity_Arr)")


            img_Arr = img_Arr.filter({ $0 != ""})
            des_Arr = des_Arr.filter({ $0 != ""})
            activity_Arr = activity_Arr.filter({ $0 != ""})

                print("img_Arr = \(img_Arr)")
                print("des_Arr = \(des_Arr)")

                gestureCV.isHidden = false
                gestureTV.isHidden = false

                gestureCV.reloadData()
                gestureTV.reloadWithAnimation()
            }
                        
            }

            }
                
              
            } catch {
               print("Parse Error: \(error)")

            }
            }

    }
   
    
    
    @IBAction func backAxn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)


    }
    
    
    
    

}
extension GestureVC : UITableViewDelegate , UITableViewDataSource ,  UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 1 {
            return activity_Arr.count
        } else {
            return des_Arr.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if indexPath.section == 1 {
            
        cell.textLabel?.text = "➢ \(activity_Arr[indexPath.row])"

            
        } else {
            if des_Arr.isEmpty == false {
                cell.textLabel?.text = "➢ \(des_Arr[indexPath.row])"

            }

        }
           
           

        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

            let returnedView = UIView(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 40 , height: 25))

            returnedView.backgroundColor = .clear
            returnedView.layer.cornerRadius = 10

           let img_View = UIImageView(frame: CGRect(x: 20, y: 3, width: 25, height: 25))

            let label = UILabel(frame: CGRect(x: 20, y: 0, width: returnedView.frame.width - 40 , height: returnedView.frame.height))
        label.textColor = .white
            label.backgroundColor = .clear
            label.textAlignment = .left
            label.font = UIFont(name: "Optima", size: 17)

    //        label.layer.cornerRadius = 10
    //        label.layer.masksToBounds = true


            switch section {


            case 1:

                if activity_Arr.isEmpty == false {
                returnedView.isHidden = false

                label.text = "Activities:"
                img_View.image = UIImage(named: "infoN")
                } else {
                    returnedView.isHidden = true

                }

            default:

                returnedView.isHidden = true

            }
//            returnedView.addSubview(img_View)
            returnedView.addSubview(label)

            return returnedView

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img_Arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GetureDetailsCVC
        if img_Arr.count > 1 {
            cell.myPageCntrl.isHidden = false
            cell.myPageCntrl.numberOfPages = img_Arr.count

        } else {
            cell.myPageCntrl.isHidden = true

        }
        
        if GestureVariables.isGesture == true {
            cell.IMG_View.setImage(urlStr: gestureIMGUrl + img_Arr[indexPath.row])

        } else {
            cell.IMG_View.setImage(urlStr: campinIMGUrl + img_Arr[indexPath.row])

        }
        
        cell.IMG_View.layer.cornerRadius = 10
        
        return cell
    }
    
    
    
    
    
    
    
    
}
