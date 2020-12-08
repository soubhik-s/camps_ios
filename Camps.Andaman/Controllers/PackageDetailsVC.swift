//
//  PackageDetailsVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 13/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class PackageDetailsVC: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var notesLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var campTitleLbl: UILabel!
    @IBOutlet weak var IMGView: UIImageView!
    @IBOutlet weak var hotel_Lbl: UILabel!
    @IBOutlet weak var hotelsCV: UICollectionView!
    @IBOutlet weak var ititneraryView: UIView!
    
    let hotelImgArr = ["SP5","symphony_7","hotel_4"]
    var hotelTitleArr = ["Sea Princess Beach Resort","Symphony Palms Resort","Pearl Park Beach Resort"]
    let place_Arr =  ["Port_Blair", "Havelock", "Neil_Island"]
    let summerNotes = "The best time to visit seashores and beaches, soak in water slides and carpet the beach with recreational outdoor activities such as gaming, building sand castles, and enjoying the great abyss of the ocean. Walking on the flawless stretch of white sand, adorned with the special buzz of air, and a dinner betwixt louder and soothing music or attending a huge party wave sums up the most memorable day of your life."
    let autumnNotes = "Enter into the fall gateway and experience the colours of autumn season in Andaman in its true form. Dive into the depths of water landscape, visualize the colourful sea life through the naked eye and be a part of the wonderful beachside parities and night life in Andaman Islands."

    let winterNotes = "Curl up or lie down near the beach side, start a day with a cool breeze and a supper with your loved ones, and roll out to enjoy the romantic moments of life. It is the most elegant way and a beautiful spot to welcome New Year eve and gift your family or loved one’s."
    let springNotes = "Spring, also called the season of new beginnings, is covered with fresh greenery, buds and flowers bloom to showcase its real beauty, and earth seems to have recreated itself. In spring, Andaman Islands attracts tourist and allures them with its seascape nature, creates curiosity on every step, whether it’s in perceiving new species of birds or varieties of sea activities that build enthusiasm to at least experience once. If you are a bird lover, then the must-visit spot is Chidiya tapu, which is the home of numerous endemic species and the time it blooms. One can experience a lovely rhythm in the form of bird chirping sounds, a boat ride across huge mangrove forest, and much more."

      var title_Arr = ["SUMMER","SPRING","PRE-WINTER","WINTER","AUTUMN",]

    
    var timer = Timer()
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()

       
        viewChanges()

    }
    
    func viewChanges() {
        CVChanges()

        ititneraryView.makeRound()

        hotel_Lbl.makeRound()
        
        hotel_Lbl.layer.masksToBounds = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        ititneraryView.addGestureRecognizer(tap)
        IMGView.layer.cornerRadius = 10
        IMGView.layer.masksToBounds = true

        IMGView.image = ItineraryDetails.image.toImage()
        
        campTitleLbl.text = BookingDetails.package_name
        priceLbl.text = "₹ \(BookingDetails.price)"
        
        switch BookingDetails.selectedIndex {
        
        case 0:
            notesLbl.text = summerNotes
            durationLbl.text = "May / June"

        case 1:
         
            notesLbl.text = springNotes
            durationLbl.text = "March / April"

        case 2:
            
            durationLbl.text = "November / December"
            notesLbl.text = winterNotes
        
        case 3:
            durationLbl.text = "January / Febraury"
            notesLbl.text = winterNotes
       
        case 4:
            durationLbl.text = "September / October"
            notesLbl.text = autumnNotes
            
        default:
            break
        }
    
    
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)

        }
               
    }
           
       
    @objc func changeImage() {
           
        if counter < hotelImgArr.count {
               let index = IndexPath.init(item: counter, section: 0)
               self.hotelsCV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
               counter += 1
        
        } else {
               counter = 0
               let index = IndexPath.init(item: counter, section: 0)
               self.hotelsCV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               counter = 1
           }
               
         
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        print("view Tapped")
        let VC  = self.storyboard?.instantiateViewController(withIdentifier: "ItineraryVC") as! ItineraryVC
         
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func bookbBtnAxn(_ sender: UIButton) {
        if Preferrences.getUserLogin() == false {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(VC, animated: true)
        } else {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "ApplicatonFormVC1") as! ApplicatonFormVC1
            self.navigationController?.pushViewController(VC, animated: true)
        }
        
        
    }
    
    @IBAction func backAxn(_ sender: UIButton) {
        

        self.navigationController?.popViewController(animated: true)
        
    }
    

   
    
    
    
    func CVChanges() {
        let cellSize = CGSize(width:hotelsCV.frame.width - 10 , height:hotelsCV.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 1.0
        hotelsCV.setCollectionViewLayout(layout, animated: true)
        hotelsCV.delegate = self
        hotelsCV.dataSource = self
        hotelsCV.reloadData()
        hotelsCV.showsHorizontalScrollIndicator = false
    }
    
    


    
    
}
extension PackageDetailsVC:  UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    
    
    
//  MARK:  CollectionView Data
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotelImgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HotelsCVC
        cell.IMGView.layer.cornerRadius = 10
        cell.IMGView.layer.masksToBounds = true
        cell.IMGView.image = UIImage(named: "\(hotelImgArr[indexPath.row])")
        cell.titleLbl.text = hotelTitleArr[indexPath.row]
        cell.place_Lbl.text = place_Arr[indexPath.row]
        cell.myPageCntrl.currentPage = indexPath.row
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        HotelDetails.hotelIndex = indexPath.item
        print("Selected Index = \(HotelDetails.hotelIndex)")
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "HotelDetailsVC") as! HotelDetailsVC
        VC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    


   

    
    
}

