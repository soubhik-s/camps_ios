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
    
    var days_Arr = ["# Day 1","# Day 2","# Day 3","# Day 4","# Day 5","# Day 6","# Day 7","# Day 8","# Day 9","# Day 10","# Day 11", "# Day 12"  ]
   
    var title_Arr = ["Welcome ","Love & Lemon " , "Freedom Fam" , "Nature Love" , "Absolute Blue" , "Adventure Awaits" , "Tiny Tribe" , "Happy Riders ", "Grooving in Nature" , "Island Explorer" , "Savor the Moments" , "Memories"]
    
    let day_1_Arr = ["16:00 – 17:30 : Briefing and Introductory session " , "18:00 – 19:00 : Welcome Party ", "19:00- 20:30 : Cook your soup – Good Kick Start for camp. Enjoy the dinner at Camp Station. "]
  
    
    let day_2_Arr = ["4.30 : Rise Early ","5.00 - 6:00 : Practice yoga at the sunrise on Beach ", "6:00 – 7:00 : Fresh Up","7:00 – 8.00 :Breakfast & get ready for Adventurous activities. " , "8.30 - 10:30 : Transfer to Jolly Bouy Islands" , "10.30 - 12:00 : Local Sightseeing includes - Mahatma Gandhi Marine National Park. Enjoy the island by exploring the butterflies, diverse fish species and many more." ,"12.00 - 13.30 : Snorkeling Activity & Swimming" , " 13.45 - 14.30 : Lunch time - Enjoy eating a packed lunch", "14:30 - 15.30 : Glass Boat Ride 1-1.5hr" , "15.30 - 17.00 : Return to Hotel ", "17:30 - 18:30 : Fresh Up & Rest","20.30- 21.00 : Dinner – Bon Appetite ", "21:00 : Lights Off"]
    
    let day_3_Arr = ["4:30 : Rise Early ","5:00 - 6:15 : Practice yoga at the sunrise on Beach ", "6:15 – 7:15 : Fresh Up ","07:15 - 08:45 : Cook your own breakfast and relish it. " , "09:30 - 11:00 : Visit to Industries & Meeting with Artisans" , "11:00 - 13:00 : With the help of a local artisan – Handicraft Palm Mats on your own." ," 13:00 - 14:00 : Lunchtime (Packed)" , " 14:00 - 17:00 : Visit to National Memorial Cellular Jail + Carbyn Beach " , "17:00 18:00 : Light & Sound Show Cellular Jail " , "18:00 - 19:30 : Transfer back to resort " , "19:30 - 20:00 hrs : Leisure & Fresh up " , "20:00 - 21:00 : Dinner – Bon Appetite ","21:00 : Lights Off"]
    
    let day_4_Arr = ["04:00 : Rise Early and Set a journey early " , "04:30 - 05:30 : Leave Hotel Check Post to Baratang ", "06:00 - 08:00  : Reach Baratang " , "08:00 - 08:30 : Relish your packed Breakfast" , "08:30 - 09:30 : Reach Limestone cave and mud volcano through Fiber Boat from baratang." , "09:30 - 13:30 : Sightseeing – Limestone caves and Mud Volcano – Watch the natural rich that leaves you wonderstruck." ," 13:30 - 14:00 : Lunchtime (Packed) " , " 14:30 - 16:00 : Check Post Baratang to Port Blair " , "16:00 - 17:00 : Reach Camp Resort " , "17:00 - 18:30 : Leisure & Fresh up " , "18:30 - 20:30 : Birdwatching briefing session " , "20:30 - 21:00 : Dinner will be served, Enjoy " , "21:00 : Lights Off"]
    
    let day_5_Arr = ["04:00 : Rise Early  " , "04:30 - 07:30 : Bird Watching (25 campers) The other campers will continue in Beach yoga ", "07:30 - 08:30 : Fresh Up " , "08:30 - 09:30 : Breakfast & get ready for Next Islands." , "09:30 - 13:00 hrs : Transfer to Havelock Islands." , "13:00 - 14:00 : Lunch Will be Served" ," 14:30 - 17:30 : Visit Radhanagar Beach. Radhanagar beach is known as one of the cleanest beaches in Asia. This beach is good for photography. " , " 17:30 - 19:00 : Return to Resort & Fresh Up(Leisure Time) " , "19:00 20:30 : Time for some fun – ‘Freeze dance’ around the bonfire is the perfect evening time to spend. Freeze Dance - Keep dancing until the music is on and freeze when the music is off. " , "20:30 - 21:00 hrs : Dinner – Bon Appetite " , "21:00 : Lights Off"]
    
    let day_6_Arr = ["04:30 : Rise Early","05:00 - 06:30 : Practice yoga at the sunrise on Beach" , "06:30 - 07:30 : Fresh Up " , "07:30 - 08:30 : Breakfast & get ready for Adventurous activities. " , "09:00 - 13:00 : Scuba Diving, Swimming" , " 13:00 - 14:00 : Lunch will be served." , "14:00 - 15:00 hrs : Leisure", "15:00 - 17:00 : Introduction to Marine ecology program " , "17:00 - 18:00 : Return to Resort Freshen Up." , " 18:00 - 20:00 : Truth or Dare, this game is an icebreaker to get to know each other. Enjoy the Perfect bonfire " ,  "20:00 - 21:00 hrs : Dine together " , "21:00 : Lights off " ]
    
    let day_7_Arr = ["04:30 : Rise Early" , "05:00 - 06:30 : Practice yoga at the sunrise on Beach", "06:30 - 07:30 hrs: Fresh Up", "07:30 - 08:30 : Breakfast will be served" , "08:30 - 11:30 : Transfer to Tiny Island – Neil Island" , "11:30 - 13:00 : Transfer to Resort & Leisure." , "13:00 - 14:00 : Lunch will be served.." , "14:30 - 15:30 : Visit Laxmanpur beach.", "15:30 - 17:00 : Beach Volleyball" , "17:00 - 18:00 : Transfer to Resort & Freshen Up" , "18:00 - 19:30 : Question Answer Round Around Bonfire", "19:30 - 21:00 hrs : Cook(Grill) and Dine together", "21:00 : Lights off"]
    
 
    let day_8_Arr = ["04:30 : Rise Early" , "05:00 - 0630 : Practice yoga at the sunrise on Beach", "06:30 - 07:30 : Fresh Up","07:30 - 08:30 : Breakfast will be served.","08:30 - 11:30 : Bharatpur Beach ","11:30 - 13:00 : Cycling." , "13:00 - 14:00 : Lunch will be served." , "14:00 - 15:00 : Leisure", " 15:00 - 17:00 : Visit to Natural Rock" , "17:00 - 18:00 : Return to Resort Freshen Up", "18:00 - 19:00 : Share experience about their cycling & 2 Islands Trip", "19:00 - 21:00 : Cook and Dine together","21:00 : Lights off" ]
    
    let day_9_Arr = ["04:30 : Rise Early" , "05:00 - 06:30 : Practice yoga at the sunrise on Beach", "06:30 - 07:30 hrs : Fresh Up" , "07:30 - 08:30: Breakfast will be served.", "09:30 - 13:00 : Transfer to Port Blair", "13:00 - 14:00 : Lunch will be served.", "14:00 - 15:00 : Return to Camp Resort", "15:00 - 16:30 : Leisure", "16:30 - 18:30 : Tug of War activity", "18:30 - 20:30 : Cook and dine together", "21:00 : Lights off" ]
    
    let day_10_Arr = ["04:30 : Rise Early ", "05:00 - 07:30 : Bird Watching (25campers)y", "07:30 - 08:15 : Fresh Up", "08:15 - 09:00 : Breakfast will be served.", "09:00  13:00 : Port Blair Local sightseeing ", "13:00 - 14:00 : Lunch will be served." , "14:00 - 17:00 : Return to Camp Resort & Leisure", "17:00 - 20:00 : Cook and share your own dishes ", "20:00 - 21:00 : Dinner", "21:00 :  Lights Off"]
    
    let day_11_Arr = ["04:30 : Rise Early ", "05:00 - 06:30 : Practice yoga at the sunrise on Beach" , "0630 - 07:30 : Fresh Up" , "07:30 - 08:30 : Breakfast will be served." , "08:30 - 13:00 : Trek to Mount Harriet Peak" , "13:00 - 14:00  : Lunch" , "14:00 - 14:30 : Leisure" , "14:30 - 17:30 : Chidiyatapu Beach – Best for Sunset – Capture Best moments","18:30 - 19:30 : Love & Share " , "19:30 - 20:30 : Testimony & experience " , "20:30 - 21:00 : Dinner" , "21:00 : Lights Off "]

  let day_12_Arr = ["Group Photo  - Bid a bye to fellow campers with good memories"]
    let campPdf = "https://camps.goexploreandaman.com/assets/camp/camp_activities.pdf"
    var selected_Index = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {
        title_Lbl.text = title_Arr[0]

        IMG_View.layer.cornerRadius = 10
        CVChanges()
        dataTV.delegate =  self
        dataTV.dataSource = self
        title_Lbl.layer.cornerRadius = 10
        title_Lbl.layer.masksToBounds = true
        dataTV.reloadWithAnimation()
        dataCV.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func CVChanges() {
    
            
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
            popUpAlert(title: "Success", message: "Image Saved ", action: .alert)
        }
       }
    

    @IBAction func back_Axn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pdf_Btn_Axn(_ sender: UIButton) {
        guard let url = URL(string: campPdf) else {
                 return
        }
        
        if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    
    
    
}

extension ActitvityViewController: UICollectionViewDelegate , UICollectionViewDataSource  , UITableViewDelegate , UITableViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days_Arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ActivitiesCVCell
        
        cell.title_Lbl.text = days_Arr[indexPath.row]
        cell.data_View.layer.cornerRadius = 10
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selected_Index = indexPath.item
        title_Lbl.text = title_Arr[selected_Index]
        dataTV.reloadWithAnimation()
    }
    
//    Activities Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selected_Index {
        case 0:
           return day_1_Arr.count
        case 1:
            return day_2_Arr.count
        case 2:
            return day_3_Arr.count
        case 3:
            return day_4_Arr.count
        case 4:
            return day_5_Arr.count
        case 5:
            return day_6_Arr.count
        case 6:
            return day_7_Arr.count
        case 7:
            return day_8_Arr.count
        case 8:
            return day_9_Arr.count
        case 9:
            return day_10_Arr.count
        case 10:
            return day_10_Arr.count
        case 11:
            return day_12_Arr.count
       
            
        default:
            return day_1_Arr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch selected_Index {
        case 0:
            cell.textLabel?.text = "➢ \(day_1_Arr[indexPath.row])"
        case 1:
            cell.textLabel?.text = "➢ \(day_2_Arr[indexPath.row])"
        case 2:
            cell.textLabel?.text = "➢ \(day_3_Arr[indexPath.row])"
        case 3:
            cell.textLabel?.text = "➢ \(day_4_Arr[indexPath.row])"
        case 4:
            cell.textLabel?.text = "➢ \(day_5_Arr[indexPath.row])"
        case 5:
            cell.textLabel?.text = "➢ \(day_6_Arr[indexPath.row])"
        case 6:
            cell.textLabel?.text = "➢ \(day_7_Arr[indexPath.row])"
        case 7:
            cell.textLabel?.text = "➢ \(day_8_Arr[indexPath.row])"
        case 8:
            cell.textLabel?.text = "➢ \(day_9_Arr[indexPath.row])"
        case 9:
            cell.textLabel?.text = "➢ \(day_10_Arr[indexPath.row])"
        case 10:
            cell.textLabel?.text = "➢ \(day_11_Arr[indexPath.row])"
        case 11:
            cell.textLabel?.text = "➢ \(day_12_Arr[indexPath.row])"

            
        default:
            cell.textLabel?.text = "➢ \(day_1_Arr[indexPath.row])"
        }
        
        return cell
    }
    
    
    

    
    
    
    
}
