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
    
    var hotelImgArr = ["hotel_2","hotel_3","hotel_4"]
    var hotelTitleArr = ["Sea Princess Beach Resort","Symphony Palms Resort","Pearl Park Beach Resort"]
    
    let summerNotes = "The best time to visit seashores and beaches, soak in water slides and carpet the beach with recreational outdoor activities such as gaming, building sand castles, and enjoying the great abyss of the ocean. Walking on the flawless stretch of white sand, adorned with the special buzz of air, and a dinner betwixt louder and soothing music or attending a huge party wave sums up the most memorable day of your life."
    let autumnNotes = "Enter into the fall gateway and experience the colours of autumn season in Andaman in its true form. Dive into the depths of water landscape, visualize the colourful sea life through the naked eye and be a part of the wonderful beachside parities and night life in Andaman Islands."

    let winterNotes = "Curl up or lie down near the beach side, start a day with a cool breeze and a supper with your loved ones, and roll out to enjoy the romantic moments of life. It is the most elegant way and a beautiful spot to welcome New Year eve and gift your family or loved one’s."
    let springNotes = "Spring, also called the season of new beginnings, is covered with fresh greenery, buds and flowers bloom to showcase its real beauty, and earth seems to have recreated itself. In spring, Andaman Islands attracts tourist and allures them with its seascape nature, creates curiosity on every step, whether it’s in perceiving new species of birds or varieties of sea activities that build enthusiasm to at least experience once. If you are a bird lover, then the must-visit spot is Chidiya tapu, which is the home of numerous endemic species and the time it blooms. One can experience a lovely rhythm in the form of bird chirping sounds, a boat ride across huge mangrove forest, and much more."

      var title_Arr = ["SUMMER","SPRING","PRE-WINTER","WINTER","AUTUMN",]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        viewChanges()
        CVChanges()

    }
    
    func viewChanges() {
        
        ititneraryView.makeRound()

        hotel_Lbl.makeRound()
        hotel_Lbl.layer.masksToBounds = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        ititneraryView.addGestureRecognizer(tap)
        IMGView.layer.cornerRadius = 10
        IMGView.layer.masksToBounds = true
       firstImageFadeIn()
        campTitleLbl.text = BookingDetails.package_name
        durationLbl.text = BookingDetails.camp_Duration
        priceLbl.text = BookingDetails.price
        switch BookingDetails.selectedIndex {
        case 0:
            notesLbl.text = summerNotes
        case 1:
        notesLbl.text = springNotes
        case 2:
        notesLbl.text = winterNotes
        case 3:
        notesLbl.text = winterNotes
        case 4:
        notesLbl.text = autumnNotes
            
        default:
            break
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        print("view Tapped")
        let VC  = self.storyboard?.instantiateViewController(withIdentifier: "ItineraryVC") as! ItineraryVC
         
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func bookbBtnAxn(_ sender: UIButton) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ApplicatonFormVC1") as! ApplicatonFormVC1
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func backAxn(_ sender: UIButton) {
        

        self.navigationController?.popViewController(animated: true)
        
    }
    

   
    
    
    
    func CVChanges() {
      let cellSize = CGSize(width:150 , height:150)
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
        cell.IMGView.image = UIImage(named: "\(hotelImgArr[indexPath.row])")
        cell.titleLbl.text = hotelTitleArr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        HotelDetails.hotelIndex = indexPath.item
        print("Selected Index = \(HotelDetails.hotelIndex)")
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "HotelDetailsVC") as! HotelDetailsVC
        VC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    func firstImageFadeIn() {
      UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
        self.IMGView.alpha = 0.8
      }, completion: {_ in
    self.IMGView.alpha = 1

      self.IMGView.image = UIImage(named: "homepage2")
      self.secondImageFadeIn()
      })

    }
       
    
    func secondImageFadeIn() {
          
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
            self.IMGView.alpha = 0.8

        }, completion: {_ in
        self.IMGView.alpha = 1
        self.IMGView.image = UIImage(named: "homepage3")
        self.thirdImageFadeIn()
        })

    }
    func thirdImageFadeIn() {
          
      UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
        self.IMGView.alpha = 0.8

        }, completion: {_ in
        self.IMGView.alpha = 1

        self.IMGView.image = UIImage(named: "homepage1")
        self.firstImageFadeIn()
        })

    }

   

    
    
}

