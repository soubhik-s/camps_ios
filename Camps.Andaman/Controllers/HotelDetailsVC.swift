//
//  HotelDetailsVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 15/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class HotelDetailsVC: UIViewController {

    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var subTitleLbl: UILabel!
    
    @IBOutlet weak var headerIMGView: UIImageView!
    @IBOutlet weak var dataTV: UITableView!
    
    
    
    
    let about_Arr = ["Sea Princess Beach Resort is located on the Wandoor Beach. The transport hubs located not far from the resort are Garacharma Bus Station (16 Km) and Veer Savarkar International Airport (22 Km). The major tourist attraction nearby is the Mahatma Gandhi Marine National Park which is 1 km away. ","Located in Havelock Island, Symphony Palms Beach Resort is within a 15-minute drive of Kaala Pathar Beach and Elephanta Beach. This 4-star hotel is 5.9 mi (9.5 km) from Radhanagar Beach", "Set in a prime location of Andaman and Nicobar Islands, Pearl Park Beach Resort-Neil Island puts everything the city has to offer just outside your doorstep. Both business travelers and tourists can enjoy the hotel's facilities and services"]
    let room_Arr = ["The Resort is equipped with spacious rooms categorized as Beach Front Suites, Standard and Deluxe Rooms. All the rooms feature contemporary decor and are furnished in natural wood tones. Most of the rooms are equipped with a seating area, mini refrigerator, attached bathroom, satellite TV, 24 hour hot /cold water, tea/coffer maker and air conditioning.","Make yourself at home in one of the 94 air-conditioned rooms featuring LCD televisions. Cable television is provided for your entertainment. Bathrooms with showers are provided. Conveniences include desks and ceiling fans, and housekeeping is provided on a limited basis.","To be found at the hotel are 24-hour room service, free Wi-Fi in all rooms, 24-hour security, daily housekeeping, ticket service. All rooms are designed and decorated to make guests feel right at home, and some rooms come with television LCD/plasma screen, additional toilet, mirror, towels, air conditioning. The hotel offers various recreational opportunities. A welcoming atmosphere and excellent service are what you can expect during your stay at Pearl Park Beach Resort-Neil Island."]
    
       let dining_Arr = ["The signature restaurants of Sea Princess Beach Resort serve delectable dishes, an exclusively chosen menu of traditional cuisine, along with secret recipes and chef special delicacies made from organic fresh vegetables, seafood and meat. ", "Enjoy a meal at Charcoal or snacks in the coffee shop/café. The hotel also offers room service (during limited hours). Quench your thirst with your favorite drink at the bar/lounge. A complimentary continental breakfast is served daily from 7 AM to 10 AM.", "The signature restaurants of Pearl Park Beach Resort serve delectable dishes, an exclusively chosen menu of traditional cuisine, along with secret recipes and chef special delicacies made from organic fresh vegetables, seafood and meat. "]
    
    let instructions_Arr = ["Amenities are subject to availability and may be chargeable as per the hotel policy.","Extra-person charges may apply and vary depending on property policy. Government-issued photo identification and a cash deposit are required at check-in for incidental charges. ","Amenities are subject to availability and may be chargeable as per the hotel policy."]
    let seaPrincesFacilities = ["24 Hour Front Desk"," 24 Hour Security"," Air Conditioning"," Doctor on Call ", " Balcony Terrace", "Seating Area", " Fire Extinguishers", " Free Wi-Fi", "Free Parking", " Room Service", " Power Backup", " Laundry Service (Paid)"," Attached Bathrooms", " Pets not allowed"]
    let  symphonyFacilities = [" 24-hour front desk", "Restaurant", " Free self-parking", " Wi-Fi (surcharge)", " Conference Hall", " Free breakfast", " Barbeque", " Private beach", " Spa services on site", " Conference Hall", " Bar/lounge", "Coffee shop or cafe"," Room Service", "Laundry" ]
    let pearlParkFacilities = [" 24-hour front desk","Room service"," Free Wi-Fi in all rooms", " Laundry service", "Restaurant"," Valet parking", "Designated Smoking Area","Coffee shop"," Airport transfer service"," Car hire"]
    let stay_Arr = ["Sea Princes Beach Resort - Port-Blair","Symphony Palms Resort - Havelock","Pearl Park Beach Resort - Neil Island"]
    let location_Arr = ["Wandoor, Near New Wandoor Beach, Port Blair, Andaman and Nicobar Islands 744101","3, Govind Nagar Beach, Havelock Island, Andaman and Nicobar Islands 744211","Beach No. 1 Lakshmanpur Beach, Port Blair, Andaman and Nicobar Islands 744104"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewChanges()

    }
    

    func viewChanges() {
        headerIMGView.layer.cornerRadius = 10
        headerIMGView.layer.masksToBounds = true
        dataTV.reloadWithAnimation()
        switch HotelDetails.hotelIndex  {
        case 0:
        subTitleLbl.text = stay_Arr[0]
        case 1:
        subTitleLbl.text = stay_Arr[1]
        case 2:
        subTitleLbl.text = stay_Arr[2]
        default:
            break
        }
        firstImageFadeIn()
    }
   
    
    
    
    @IBAction func backBtn(_ sender: UIButton) {

      
        self.navigationController?.popViewController(animated: true)
   
    }
    


}
extension HotelDetailsVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 5 {
            switch HotelDetails.hotelIndex {

            case 0:
                return seaPrincesFacilities.count
            
            case 1:
                return symphonyFacilities.count
            
            case 2:
                return pearlParkFacilities.count
            
            default:
            
            return seaPrincesFacilities.count
            
                        
            }
            
        } else {
        return 1
        }

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        switch indexPath.section {
       
        case 0:
           
          
            
            switch HotelDetails.hotelIndex {
            
            case 0:
                cell.textLabel!.text = location_Arr[0]
            
            case 1:
            cell.textLabel!.text = location_Arr[1]
            
            case 2:
            cell.textLabel!.text = location_Arr[2]
            
            default:
                
            break
            
            }
            return cell
        case 1:
        
        
         
         switch HotelDetails.hotelIndex {
         
         case 0:
         cell.textLabel!.text = about_Arr[0]
         
         case 1:
         cell.textLabel!.text = about_Arr[1]
         
         case 2:
         cell.textLabel!.text = about_Arr[2]
         
         default:
             
         break
         
         }
         return cell
        
        case 2:
        
     
         switch HotelDetails.hotelIndex {
         
         case 0:
         cell.textLabel!.text = room_Arr[0]
         
         case 1:
         cell.textLabel!.text = room_Arr[1]
         
         case 2:
         cell.textLabel!.text = room_Arr[2]
         
         default:
             
         break
         
         }
         return cell
            
        case 3:
       
         switch HotelDetails.hotelIndex {
         
         case 0:
         cell.textLabel!.text = dining_Arr[0]
         
         case 1:
         cell.textLabel!.text = dining_Arr[1]
         
         case 2:
         cell.textLabel!.text = dining_Arr[2]
         
         default:
             
         break
         
         }
         return cell
        
        case 4:
        
        
         switch HotelDetails.hotelIndex {
         
         case 0:
         cell.textLabel!.text = instructions_Arr[0]
         
         case 1:
         cell.textLabel!.text = instructions_Arr[1]
         
         case 2:
         cell.textLabel!.text = instructions_Arr[2]
         
         default:
             
         break
         
         }
         return cell
    
        case 5:
        
         switch HotelDetails.hotelIndex {
              
         case 0:
             
            cell2.textLabel!.text = seaPrincesFacilities[indexPath.row]
                        
         case 1:
            cell2.textLabel!.text = symphonyFacilities[indexPath.row]
         
         case 2:
            cell2.textLabel!.text = pearlParkFacilities[indexPath.row]
         
         default:
         
             break
             
         }
         return cell2
        
            
        
        default:
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let returnedView = UIView(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 40 , height: 25))

        returnedView.backgroundColor = .clear
        returnedView.layer.cornerRadius = 10

       let img_View = UIImageView(frame: CGRect(x: 20, y: 3, width: 17, height: 17))

        let label = UILabel(frame: CGRect(x: 50, y: 0, width: returnedView.frame.width - 40 , height: returnedView.frame.height))
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.font = UIFont(name: "Optima", size: 15)

//        label.layer.cornerRadius = 10
//        label.layer.masksToBounds = true


        switch section {

        case 0:
        label.text = "Location"
        img_View.image = UIImage(named: "loc")

        case 1:
            label.text = "About"
            img_View.image = UIImage(named: "infoN")
        case 2:
        label.text = "Rooms"
            img_View.image = UIImage(named: "bed_3")

        case 3:
            label.text = "Dinning"
            img_View.image = UIImage(named: "din1")
        case 4:
        label.text = "Instructions"
            img_View.image = UIImage(named: "bell_new")

        case 5:
            label.text = "Facilities"
            img_View.image = UIImage(named: "facility")



        default:

            label.text = ""

        }
        returnedView.addSubview(img_View)
        returnedView.addSubview(label)

        return returnedView




    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    
    func firstImageFadeIn() {
     
        
        
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
            self.headerIMGView.alpha = 0.8

            
       }, completion: {_ in
   
        self.headerIMGView.alpha = 1.0

        switch HotelDetails.hotelIndex {
        case 0:
        self.headerIMGView.image = UIImage(named: "SP2")

        case 1:
        self.headerIMGView.image = UIImage(named: "sym2")

           
        case 2:
        self.headerIMGView.image = UIImage(named: "pp2")

        default:
            break
        }
       self.secondImageFadeIn()
       })

     }
        
    func secondImageFadeIn() {
     
        
    UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
        self.headerIMGView.alpha = 0.8

        
       }, completion: {_ in
         self.headerIMGView.alpha = 1.0


        switch HotelDetails.hotelIndex {
        case 0:
        self.headerIMGView.image = UIImage(named: "SP3")

        case 1:
        self.headerIMGView.image = UIImage(named: "sym3")

           
        case 2:
        self.headerIMGView.image = UIImage(named: "pp3")

        default:
            break
        }
        
       self.thirdImageFadeIn()
       })

     }
     
     func thirdImageFadeIn() {
           
         UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
           self.headerIMGView.alpha = 0.8

         }, completion: {_ in
            self.headerIMGView.alpha = 1.0

        switch HotelDetails.hotelIndex {
                 
        case 0:
        self.headerIMGView.image = UIImage(named: "SP4")

        case 1:
        self.headerIMGView.image = UIImage(named: "sym4")

        case 2:
        self.headerIMGView.image = UIImage(named: "pp4")

        default:
        break
        
        }
        self.fourtImageFadeIn()
        })
     }
    
    func fourtImageFadeIn() {
    
      
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
            
            self.headerIMGView.alpha = 0.8

            
          }, completion: {_ in
            self.headerIMGView.alpha = 1.0

            
           switch HotelDetails.hotelIndex {
           case 0:
           self.headerIMGView.image = UIImage(named: "SP5")

           case 1:
           self.headerIMGView.image = UIImage(named: "sym5")

              
           case 2:
           self.headerIMGView.image = UIImage(named: "pp5")

           default:
               break
           }
          self.fifthImageFadeIn()
          })

    }
   
    func fifthImageFadeIn() {
   
        
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
            self.headerIMGView.alpha = 0.8
            
        }, completion: {_ in
       self.headerIMGView.alpha = 1.0


            switch HotelDetails.hotelIndex {
            
                case 0:
                   self.headerIMGView.image = UIImage(named: "SP1")

                case 1:
                    self.headerIMGView.image = UIImage(named: "sym1")

                case 2:
                    self.headerIMGView.image = UIImage(named: "pp1")
                default:
            
                    break
            
            }
          
          self.firstImageFadeIn()
          })

       
    }
    
}
