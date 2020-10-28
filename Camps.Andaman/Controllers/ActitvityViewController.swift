//
//  ActitvityViewController.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 30/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class ActitvityViewController: UIViewController {

    
    @IBOutlet weak var IMG_View: UIImageView!
    @IBOutlet weak var details_View: UIView!
    @IBOutlet weak var contentTitle_Lbl: UILabel!
    @IBOutlet weak var eve_Lbl: UILabel!
    @IBOutlet weak var noon_Lbl: UILabel!
    @IBOutlet weak var morning_Lbl: UILabel!
    @IBOutlet weak var night_Lbl: UILabel!
    @IBOutlet weak var dataCV: UICollectionView!
    @IBOutlet weak var calender_Lbl: UILabel!
    
    var dataArray:[ItineraryResponseElement] = []
    var days_Arr = ["# Day 1","# Day 2","# Day 3","# Day 4","# Day 5","# Day 6","# Day 7","# Day 8","# Day 9","# Day 10","# Day 11", "# Day 12" , "# Day 13" , "# Day 14" ]
    var childDate_Arr = ["1st" , "2nd" , "3rd" , "4th", "5th","6th","7th","8th","9th","10th","11th","12th","13th","14th"]
    var adultDate_Arr = [ "15th","16th" , "17th" , "18th" , "19th", "20th", "21st", "22th", "23th", "24th", "25th", "26th", "27th", "28th", "29th", "30th"]

    var pkg_Id:[String] = []
    var iti_Arr:[String] = []
    var morning_Arr:[String] = []
    var noon_Arr:[String] = []
    var eve_Arr:[String] = []
    var night_Arr:[String] = []
    var isAdult:Bool = false
    var season_name = ""
    var age_group = ""
    var pkg_Date = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {
        IMG_View.layer.cornerRadius = 10
        details_View.isHidden = true
        dataCV.isHidden = true
        CVChanges()
        getPackageList()
    }
    
    func CVChanges() {
    
        dataCV.isHidden = true
            
        let cellSize = CGSize(width:80 , height:70)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        dataCV.setCollectionViewLayout(layout, animated: true)
        dataCV.delegate = self
        dataCV.dataSource = self
        dataCV.showsHorizontalScrollIndicator = true
                
    }
    
    
    @IBAction func save_Axn(_ sender: UIButton) {
        
        /// Save `image` into Photo Library
        UIImageWriteToSavedPhotosAlbum(IMG_View.image!, self,
               #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    /// Process photo saving result
       @objc func image(_ image: UIImage,
           didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
           if let error = error {
               print("ERROR: \(error)")
           } else {
            popUpAlert(title: "Success", message: "Photo Saved ", action: .alert)
        }
       }
    

    @IBAction func back_Axn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func seasonActivity() {
           
        let day = getCurrentday()
        let currentMonth = getCurrentMonth()
        let cureentYear = getCurrentYear()
          
        switch DashboardVariables.pkgID {
        
        case "1":
        
            if currentMonth < 5 {
                pkg_Date = "SummerCamp - May / \(cureentYear)"
                           
            }  else {
                pkg_Date = "SummerCamp - May / \(cureentYear + 1)"

            }
       
        case "6":
        
            if currentMonth < 6 {
                       
            pkg_Date = "SummerCamp - June / \(cureentYear)"
                       
            } else {
                pkg_Date = "summerCamp - June / \(cureentYear + 1)"
                
            }
            
        case "2" :
            
            if currentMonth < 3 {
                       
            pkg_Date = "March / \(cureentYear)"
                       
            }  else {
                pkg_Date = "March / \(cureentYear + 1)"
                
            }
        
        case "7" :
            
            if currentMonth < 4 {
                       
            pkg_Date = "April / \(cureentYear)"
                       
            } else {
                pkg_Date = "April / \(cureentYear + 1)"
                
            }
            
        case  "3" :
            if currentMonth < 11 {
                       
            pkg_Date = "November / \(cureentYear)"
                       
            }  else {
                pkg_Date = "November / \(cureentYear + 1)"
                
            }
            
        case "8" :
            
            if currentMonth < 12 {
                       
            pkg_Date = "December / \(cureentYear)"
                       
            }  else {
                pkg_Date = "December / \(cureentYear + 1)"
                
            }
            
        case "4" :
            
            if currentMonth < 1 {
                       
            pkg_Date = "January / \(cureentYear)"
                       
            }  else {
                pkg_Date = "January / \(cureentYear + 1)"
                
            }
        case "9":
            if currentMonth < 2 {
                       
            pkg_Date = "Febraury / \(cureentYear)"
                       
            }  else {
                pkg_Date = "Febraury / \(cureentYear + 1)"
                
            }
        
        case "5" :
            if currentMonth < 9 {
                       
            pkg_Date = "September / \(cureentYear)"
                       
            }  else {
                pkg_Date = "September / \(cureentYear + 1)"
                
            }
            
        case "10" :
            if currentMonth < 10 {
                       
            pkg_Date = "October / \(cureentYear)"
                       
            }  else {
                pkg_Date = "October / \(cureentYear + 1)"
                
            }
        
        default:
            pkg_Date = ""
        }
  
       
       
    }
    
    func getData()  {
        
        if reach.isConnectedToNetwork() == true {
        showActivityIndicator()
        ApiService.callPostToken(url: ClientInterface.itineraryUrl, params: "", methodType: "GET", tag: "ItineraryList", finish:finishPost)
        
        } else {
        self.view.makeToast("Check Internet Connection")
        }
    }
        
    func getPackageList()  {
           
           if reach.isConnectedToNetwork() == true {
           showActivityIndicator()
           ApiService.callPostToken(url: ClientInterface.packagesUrl, params: "", methodType: "GET", tag: "PKG", finish:finishPost)
           
           } else {
           self.view.makeToast("Check Internet Connection")
           }
       }
           
        
           
      
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        
        hideActivityIndicator()
        
        if tag == "PKG" {
            
            do {
           
                if let jsonData = data {
                let parsedData = try JSONDecoder().decode(PackageResponse.self, from: jsonData)
                    print(parsedData)
                    
                    if parsedData.isEmpty == false {
                        for adultData in parsedData {
                            if adultData.package_id == DashboardVariables.pkgID {
                                season_name = adultData.package_season_name
                                age_group = adultData.age_group

                                print("season_name = \(season_name)")
                                print("age_group = \(age_group)")
                                getData()
                            }
                        }
                        dataCV.isHidden = false
                        dataCV.reloadData()
                    }
                    
                }
            } catch {
            print("Parse Error: \(error)")

            }
            
        } else {
            
        
        do {
        if let jsonData = data {
        let parsedData = try JSONDecoder().decode(ItineraryResponse.self, from: jsonData)
        print(parsedData)
        
                        
       dataArray = parsedData
        print("dataArray = \(dataArray)")
                   
        for itinerary_Data in dataArray {
        
            if itinerary_Data.seasonName == season_name && itinerary_Data.ageGroup == age_group {
               
            iti_Arr = itinerary_Data.itienaryName
            print("iti_Arr = \(iti_Arr)")
            
            morning_Arr = itinerary_Data.morningActivity
            print("morning_Arr = \(morning_Arr)")

            noon_Arr = itinerary_Data.afterNoonActivity
            print("noon_Arr = \(noon_Arr)")

            eve_Arr = itinerary_Data.eveningActivity
            print("eve_Arr = \(eve_Arr)")

            night_Arr = itinerary_Data.overNightActivity
            print("night_Arr = \(night_Arr)")
                
             
            if itinerary_Data.ageGroup == "adult" {
            isAdult = true
            
            } else {
                isAdult = false
                
            }
               
            } else {
                print("Other ID")
            }
            }
                
         
            if morning_Arr.count < iti_Arr.count {
            
            morning_Arr.append("")
            print("morning_Append")
            
            } else  {
            print("No Moringing_Append")
            
            }
                       
                       
            if noon_Arr.count < iti_Arr.count {
                noon_Arr.append("")
                print("Noon_Append")
                
            } else {
              print("No Noon_Append")

            }
                     
            
            if eve_Arr.count < iti_Arr.count {
                eve_Arr.append("")
                print("Evening_Append")
                       
            } else {
                print("No Evening_Append")

            }
                      
            if night_Arr.count < iti_Arr.count {
                night_Arr.append("")
                print("Night_Append")
                
            } else {
            print("No Night_Append")

            }
                   
            details_View.isHidden = false 
                   
            morning_Lbl.text = morning_Arr[0]
            noon_Lbl.text = noon_Arr[0]
            eve_Lbl.text = eve_Arr[0]
            night_Lbl.text = night_Arr[0]

                      
            contentTitle_Lbl.text = days_Arr[0] + " # \(iti_Arr[0]).. "
         
                   
            dataCV.isHidden = false
            dataCV.reloadData()
        
        }
                
        } catch {
        print("Parse Error: \(error)")
                
        }
        
    }
    }
}

extension ActitvityViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iti_Arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ActivitiesCVCell
//        let cellPath = dataArray[indexPath.row]
        cell.data_View.layer.cornerRadius = 10
        cell.contentView.layer.cornerRadius = 10
       
        
        cell.title_Lbl.text = days_Arr[indexPath.row]
        cell.mrng_Lbl.text =  morning_Arr[indexPath.row]
        cell.itinerary_Lbl.text = iti_Arr[indexPath.row]
        
        cell.noon_Lbl.text = noon_Arr[indexPath.row]
        cell.eve_Lbl.text =  eve_Arr[indexPath.row]
        cell.night_Lbl.text = night_Arr[indexPath.row]
        
        if isAdult == true {
        cell.title_Lbl.text = adultDate_Arr[indexPath.row]

        } else {
            cell.title_Lbl.text = childDate_Arr[indexPath.row]

        }
       
        
        cell.data_View.layer.borderWidth = 0.5
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! ActivitiesCVCell
        
        details_View.isHidden = false
        contentTitle_Lbl.text = currentCell.title_Lbl.text! + " # " + "\(currentCell.itinerary_Lbl.text!)..  "
        morning_Lbl.text = currentCell.mrng_Lbl.text!
        noon_Lbl.text = currentCell.noon_Lbl.text!
        eve_Lbl.text = currentCell.eve_Lbl.text!
        night_Lbl.text = currentCell.night_Lbl.text!
        
        print("title = \(currentCell.title_Lbl.text!)")
    }
    
    
    
}
