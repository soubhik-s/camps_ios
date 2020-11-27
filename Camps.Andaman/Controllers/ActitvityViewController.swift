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
   
    @IBOutlet weak var dataTV: UITableView!
    @IBOutlet weak var title_Lbl: UILabel!
    @IBOutlet weak var dataCV: UICollectionView!
    @IBOutlet weak var calender_Lbl: UILabel!
    
    var dataArray:[ItineraryResponseElement] = []
    var days_Arr = ["# Day 1","# Day 2","# Day 3","# Day 4","# Day 5","# Day 6","# Day 7","# Day 8","# Day 9","# Day 10","# Day 11", "# Day 12"  ]
   
    var title_Arr = ["Welcome 😀 ","Love & Lemon 🥰" , "Freedom Fam" , "Nature Love" , "Absolute Blue" , "Adventure Awaits" , "Tiny Tribe" , "Happy Riders ", "Grooving in Nature" , "Island Explorer" , "Savor the Moments" , "Memories"]
    
    let day_1_Arr = ["16:00 – 17:30 : Briefing and Introductory session " , "18:00 – 19:00 : Welcome Party ", "19:00- 20:30 : Cook your soup – Good Kick Start for camp. Enjoy the dinner at Camp Station. "]
  
    
    let day_2_Arr = ["4.30 : Rise Early ","5.00 - 6:00 : Practice yoga at the sunrise on Beach ", "6:00 – 7:00 : Fresh Up","7:00 – 8.00 :Breakfast & get ready for Adventurous activities. " , "8.30 - 10:30 : Transfer to Jolly Bouy Islands" , "10.30 - 12:00 : Local Sightseeing includes - Mahatma Gandhi Marine National Park. Enjoy the island by exploring the butterflies, diverse fish species and many more." ,"12.00 - 13.30 : Snorkeling Activity & Swimming" , " 13.45 - 14.30 : Lunch time - Enjoy eating a packed lunch", "14:30 - 15.30 : Glass Boat Ride 1-1.5hr" , "15.30 - 17.00 : Return to Hotel ", "17:30 - 18:30 : Fresh Up & Rest","20.30- 21.00 : Dinner – Bon Appetite ", "21:00 : Lights Off"]
    
    let day_3_Arr = ["4.30 : Rise Early ","5.00 - 6:15 : Practice yoga at the sunrise on Beach ", "6:15 – 7:15 : Fresh Up ","0715 hrs to 0845 hrs : Cook your own breakfast and relish it. " , "0930 hrs to 1100 hrs : Visit to Industries & Meeting with Artisans" , "1100 hrs to 1300 hrs : With the help of a local artisan – Handicraft Palm Mats on your own." ," 1300 hrs to 1400 hrs : Lunchtime (Packed)" , " 1400 hrs to 1700 hrs : Visit to National Memorial Cellular Jail + Carbyn Beach " , "1700 hrs to 1800 hrs : Light & Sound Show Cellular Jail " , "1800 hrs to 1930 hrs : Transfer back to resort " , "1930 hrs to 2000 hrs : Leisure & Fresh up " , "2000 hrs to 2100] hrs  : Dinner – Bon Appetite ","2100 hrs : Lights Off"]
    
    let day_4_Arr = ["0400 hrs : Rise Early and Set a journey early " , "0430 hrs to 0530 hrs : Leave Hotel Check Post to Baratang ", "0600 hrs to 0800 hrs : Reach Baratang " , "0800 hrs to 0830 hrs : Relish your packed Breakfast" , "0830 hrs to 0930 hrs : Reach Limestone cave and mud volcano through Fiber Boat from baratang." , "0930 hrs to 1330 hrs : Sightseeing – Limestone caves and Mud Volcano – Watch the natural rich that leaves you wonderstruck." ," 1330 hrs to 1400 hrs: Lunchtime (Packed) " , " 1430 hrs to 1600 hrs : Check Post Baratang to Port Blair " , "1600 hrs to 1700 hrs : Reach Camp Resort " , "1700 hrs to 1830 hrs : Leisure & Fresh up " , "1830 hrs to 2030 hrs : Birdwatching briefing session " , "2030 hrs to 2100 hrs : Dinner will be served, Enjoy " , "2100 hrs : Lights Off"]
    
    let day_5_Arr = ["0400 hrs : Rise Early  " , "0430 hrs to 0730 hrs : Bird Watching (25 campers) The other campers will continue in Beach yoga ", "0730 hrs to 0830 hrs : Fresh Up " , "0830 hrs to 0930 hrs : Breakfast & get ready for Next Islands." , "0930 hrs to 1300 hrs : Transfer to Havelock Islands." , "1300 hrs to 1400 hrs : Lunch Will be Served" ," 1430 hrs to 1730 hrs : Visit Radhanagar Beach. Radhanagar beach is known as one of the cleanest beaches in Asia. This beach is good for photography. " , " 1730 hrs to 1900 hrs : Return to Resort & Fresh Up(Leisure Time) " , "1900 hrs to 2030 hrs : Time for some fun – ‘Freeze dance’ around the bonfire is the perfect evening time to spend. Freeze Dance - Keep dancing until the music is on and freeze when the music is off. " , "2030 hrs to 2100 hrs : Dinner – Bon Appetite " , "2100 hrs: Lights Off"]
    
    let day_6_Arr = ["04:30 : Rise Early","0500 hrs to 0630 hrs : Practice yoga at the sunrise on Beach" , "0630 hrs to 0730 hrs : Fresh Up " , "0730 hrs to 0830 hrs : Breakfast & get ready for Adventurous activities. " , "0900 hrs to 1300 hrs : Scuba Diving, Swimming" , " 1300 hrs to 1400 hrs : Lunch will be served." , "1400 hrs to 1500 hrs : Leisure", "1500 hrs to 1700 hrs : Introduction to Marine ecology program " , "1700 hrs to 1800 hrs : Return to Resort Freshen Up." , " 1800 hrs to 2000 hrs : Truth or Dare, this game is an icebreaker to get to know each other. Enjoy the Perfect bonfire " ,  "2000 hrs to 2100 hrs : Dine together " , "2100 hrs : Lights off " ]
    
    let day_7_Arr = ["0430 hrs : Rise Early" , "0500 hrs to 0630 hrs : Practice yoga at the sunrise on Beach", "0630 hrs to 0730 hrs: Fresh Up", "0730 hrs to 0830 hrs : Breakfast will be served" , "0830 hrs to 1130 hrs : Transfer to Tiny Island – Neil Island" , "1130 hrs to 1300 hrs : Transfer to Resort & Leisure." , "1300 hrs to 1400 hrs : Lunch will be served.." , "1430 hrs to 1530 hrs : Visit Laxmanpur beach.", "1530 hrs to 1700 hrs  : Beach Volleyball" , "1700 hrs to 1800 hrs : Transfer to Resort & Freshen Up" , "1800 hrs to 1930 hrs : Question Answer Round Around Bonfire", "1930 hrs to 2100 hrs : Cook(Grill) and Dine together", "2100 hrs : Lights off"]
  let day_8_Arr = ["0430 hrs : Rise Early" , "0500 hrs to 0630 hrs : Practice yoga at the sunrise on Beach", "0630 hrs to 0730 hrs : Fresh Up","0730 hrs to 0830 hrs : Breakfast will be served.","0830 hrs to 1130 hrs : Bharatpur Beach ","1130 hrs to 1300 hrs : Cycling." , "1300 hrs to 1400 hrs : Lunch will be served." , "1400 hrs to 1500 hrs : Leisure", " 1500 hrs to 1700 hrs : Visit to Natural Rock" , "1700 hrs to 1800 hrs : Return to Resort Freshen Up", "1800 hrs to 1900 hrs : Share experience about their cycling & 2 Islands Trip", "1900 hrs to 2100 hrs : Cook and Dine together","2100 hrs : Lights off" ]
    
    let day_9_Arr = ["0430 hrs : Rise Early" , "0500 hrs to 0630 hrs : Practice yoga at the sunrise on Beach", "0630 hrs to 0730 hrs : Fresh Up" , "0730 hrs to 0830 hrs  : Breakfast will be served.", "0930 hrs to 1300 hrs : Transfer to Port Blair", "1300 hrs to 1400 hrs : Lunch will be served.", "1400 hrs to 1500 hrs : Return to Camp Resort", "1500 hrs to 1630 hrs : Leisure", "1630 hrs to 1830 hrs : Tug of War activity", "1830 hrs to 2030 hrs : Cook and dine together", "2100 hrs : Lights off" ]
    
    let day_10_Arr = ["0430 hrs : Rise Early ", "0500 hrs to 0730 hrs : Bird Watching (25campers)y", "0730 hrs to 0815 hrs : Fresh Up", "0815 hrs to 0900 hrs : Breakfast will be served.", "0900 hrs to 1300 hrs :Port Blair Local sightseeing ", "1300 hrs to 1400 hrs : Lunch will be served." , "1400 hrs to 1700 hrs : Return to Camp Resort & Leisure", "1700 hrs to 2000 hrs : Cook and share your own dishes ", "2000 hrs to 2100 hrs : Dinner", "2100 hrs :  Lights Off"]
    
    let day_11_Arr = ["0430 hrs : Rise Early ", "0500 hrs to 0630 hrs : Practice yoga at the sunrise on Beach" , "0630 hrs to 0730 hrs : Fresh Up" , "0730 hrs to 0830 hrs : Breakfast will be served." , "0830 hrs to 1300 hrs : Trek to Mount Harriet Peak" , "1300 hrs to 1400 hrs : Lunch" , "1400 hrs to 1430 hrs : Leisure" , "1430 hrs to 1730 hrs : Chidiyatapu Beach – Best for Sunset – Capture Best moments","1830 hrs to 1930 hrs : Love & Share " , "1930 hrs to 2030 hrs : Testimony & experience " , "2030 hrs to 2100 hrs : Dinner" , "2100 hrs : Lights Off "]
    let day_12_Arr = ["Group Photo  - Bid a bye to fellow campers with good memories"]
    var selected_Index = 0
//    var pkg_Id:[String] = []
//    var iti_Arr:[String] = []
//    var morning_Arr:[String] = []
//    var noon_Arr:[String] = []
//    var eve_Arr:[String] = []
//    var night_Arr:[String] = []
//    var isAdult:Bool = false
//    var season_name = ""
//    var age_group = ""
//    var pkg_Date = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {
        IMG_View.layer.cornerRadius = 10
        dataCV.isHidden = true
        CVChanges()
        dataTV.delegate =  self
        dataTV.dataSource = self
        title_Lbl.layer.cornerRadius = 10
        dataTV.reloadWithAnimation()
        dataCV.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
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
    

    
    
    
}

extension ActitvityViewController: UICollectionViewDelegate , UICollectionViewDataSource  , UITableViewDelegate , UITableViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days_Arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ActivitiesCVCell
        
        cell.title_Lbl.text = days_Arr[indexPath.row]
        

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! ActivitiesCVCell
        
        selected_Index = indexPath.item
      
        showActivities()
        print("title = \(currentCell.title_Lbl.text!)")
    }
    
//    Activities Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selected_Index {
        case 0:
           return day_1_Arr.count
        case 1:
            return day_2_Arr.count
        case 2:
            return   day_3_Arr.count
        case 3:
            return  day_4_Arr.count
        case 4:
            return  day_5_Arr.count
        case 5:
            return  day_6_Arr.count
        case 6:
            return  day_7_Arr.count
        case 7:
            return   day_8_Arr.count
        case 8:
            return   day_9_Arr.count
        case 9:
            return   day_10_Arr.count
        case 10:
            return   day_10_Arr.count
        case 11:
            return    day_12_Arr.count
       
            
        default:
            return   day_1_Arr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch selected_Index {
        case 0:
            cell.textLabel?.text = " ➢ \(day_1_Arr[indexPath.row])"
        case 1:
            cell.textLabel?.text = day_2_Arr[indexPath.row]
        case 2:
            cell.textLabel?.text = day_3_Arr[indexPath.row]
        case 3:
            cell.textLabel?.text = day_4_Arr[indexPath.row]
        case 4:
            cell.textLabel?.text = day_5_Arr[indexPath.row]
        case 5:
            cell.textLabel?.text = day_6_Arr[indexPath.row]
        case 6:
            cell.textLabel?.text = day_7_Arr[indexPath.row]
        case 7:
            cell.textLabel?.text = day_8_Arr[indexPath.row]
        case 8:
            cell.textLabel?.text = day_8_Arr[indexPath.row]
        case 9:
            cell.textLabel?.text = day_8_Arr[indexPath.row]
        case 10:
            cell.textLabel?.text = day_8_Arr[indexPath.row]
        case 11:
            cell.textLabel?.text = day_8_Arr[indexPath.row]
      
            
        default:
            cell.textLabel?.text = day_1_Arr[indexPath.row]
        }
        
        return cell
    }
    
    
    
    func showActivities() {
        
        switch selected_Index {
        case 0:
            title_Lbl.text = title_Arr[selected_Index]
           
        case 1:
            title_Lbl.text = title_Arr[selected_Index]
           
        case 2:
            title_Lbl.text = title_Arr[selected_Index]
          
        case 3:
            title_Lbl.text = title_Arr[selected_Index]
           
        case 4:
            title_Lbl.text = title_Arr[selected_Index]
           
        case 5:
            title_Lbl.text = title_Arr[selected_Index]
          
        case 6:
            title_Lbl.text = title_Arr[selected_Index]
          
        case 7:
            title_Lbl.text = title_Arr[selected_Index]
           
        case 8:
            title_Lbl.text = title_Arr[selected_Index]
          
        case 9:
            title_Lbl.text = title_Arr[selected_Index]
          
        case 10:
            title_Lbl.text = title_Arr[selected_Index]
           
        case 11:
            title_Lbl.text = title_Arr[selected_Index]
           
        default:
            break
        }
        
        
        
    }
    
    
    
    
}
