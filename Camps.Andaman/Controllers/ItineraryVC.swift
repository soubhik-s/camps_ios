//
//  ItineraryVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 04/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class ItineraryVC: UIViewController {

    @IBOutlet weak var campTitle_Lbl: UILabel!
    @IBOutlet weak var dataTV: UITableView!
    @IBOutlet weak var description_Lbl: UILabel!
    
    @IBOutlet weak var img_View: UIImageView!
    
    
    var sectionStats = [Bool](repeating: true, count: 3)

    var selectedRowIndex = -1
    var dataArray:ItineraryResponse = []
    var iti_Arr:[String] = []
    var morning_Arr:[String] = []
    var noon_Arr:[String] = []
    var eve_Arr:[String] = []
    var night_Arr:[String] = []
    var inc_Arr:[String] = []
    var exc_Arr:[String] = []
    
    var daya_Arr = ["# Day 1", "# Day 2","# Day 3","# Day 4","# Day 5","# Day 6","# Day 7","# Day 8","# Day 9","# Day 10","# Day 11","# Day 12", "# Day 13",]
       
    var expandedIndexSet : IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    func viewChanges() {
        img_View.layer.cornerRadius = 10
        description_Lbl.isHidden = true
        campTitle_Lbl.isHidden =  true
        img_View.isHidden = true
        dataTV.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getData()
    }
    
    
    @IBAction func backBtn_Axn(_ sender: UIButton) {


        self.navigationController?.popViewController(animated: true)

        
       
    }
       
    func getData()  {
    
        if reach.isConnectedToNetwork() == true {
            showActivityIndicator()
        ApiService.callPostToken(url: ClientInterface.itineraryUrl, params: "", methodType: "GET", tag: "ItineraryList", finish:finishPost)
    
        } else {
        self.view.makeToast("Check Internet Connection")
        }
    }
    
    
       
    func finishPost (message:String, data:Data? , tag: String) -> Void {
    
        hideActivityIndicator()
    
        do {
        if let jsonData = data {
    
            let parsedData = try JSONDecoder().decode(ItineraryResponse.self, from: jsonData)
            print(parsedData)
    
//
            dataArray = parsedData
            print("dataArray = \(dataArray)")
        
            for itinerary_Data in dataArray {
                if itinerary_Data.seasonName == ItineraryDetails.season_Name && itinerary_Data.ageGroup == ItineraryDetails.age_Group {

//                if itinerary_Data.itineraryID == ItineraryDetails.itinerary_ID {
                    description_Lbl.text = itinerary_Data.itineraryDescription
                    
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

                    inc_Arr = itinerary_Data.campInclusions 
                print("inc_Arr = \(inc_Arr)")

                    exc_Arr = itinerary_Data.campExclusions 
                print("exc_Arr = \(exc_Arr)")
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


            
            
            dataTV.isHidden = false
            
            img_View.isHidden = false
            campTitle_Lbl.isHidden = false
            
            description_Lbl.isHidden = false
            
            img_View.image = ItineraryDetails.image.toImage()
            campTitle_Lbl.text = ItineraryDetails.title
            dataTV.reloadWithAnimation()
            
            }
            
        } catch {
            print("Parse Error: \(error)")
            
        }
    
    }
                    
}
extension ItineraryVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
          3
      }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
////          guard sectionStats[section] else {
////              return 0
////          }


        print("morning_Arr = \(morning_Arr.count)")
        print("noon_Arr = \(noon_Arr.count)")
        print("eve_Arr = \(eve_Arr.count)")
//        print("night_Arr = \(night_Arr.count)")

            if section == 0 {
            print("iti = \(iti_Arr.count)")
                print("dataArray = \(dataArray.count)")
            return iti_Arr.count

            } else if  section == 1 {
            print("inc = \(inc_Arr.count)")
            return inc_Arr.count

            } else   {
            print("exc = \(exc_Arr.count)")
            return exc_Arr.count

            }


        }
        
       
      
      
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          
//        let cellPath = dataArray[indexPath.row]
//        print("cellPath = \(cellPath)")
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! Inc_ExcTVC
          
        
          switch indexPath.section {
          case 0:
              let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PackageDetailsTVC

              cell.titleLbl.text = " ☞ \(iti_Arr[indexPath.row]) "
              cell.morningLbl.text = morning_Arr[indexPath.row]
              cell.afterNoonLbl.text = noon_Arr[indexPath.row]
              cell.eveningLbl.text = eve_Arr[indexPath.row]
              cell.nightLbl.text =  night_Arr[indexPath.row]
              
              cell.labelView.layer.cornerRadius = 5
        
             
              if expandedIndexSet.contains(indexPath.row) {
              cell.IMGView.image = UIImage(named: "up_clr")
              } else {
              cell.IMGView.image = UIImage(named: "down_clr")
              }
              


              return cell
              
    
    case 1:
       
        cell2.titleLbl.text = " ➢ \(inc_Arr[indexPath.row]) "
        return cell2
          
    case 2:
        
        cell2.titleLbl.text = " ➢ \(exc_Arr[indexPath.row]) "
        return cell2
              
        
    default:
            return cell2
          
        }
          
          
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
        if(expandedIndexSet.contains(indexPath.row)){

            expandedIndexSet.remove(indexPath.row)
        } else {
        expandedIndexSet.insert(indexPath.row)
        }
               
        tableView.reloadRows(at: [indexPath], with: .fade)

        } else {
            print("Other Sections")
        }
      }
      
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
               
          let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: dataTV.frame.width , height: 30))
               
          returnedView.backgroundColor = .clear
              
                  

          let label = UILabel(frame: CGRect(x: 0, y: 0, width: returnedView.frame.width, height: returnedView.frame.height))
          label.textColor = .white
          label.backgroundColor = .baseColor
          label.textAlignment = .center
          label.font = UIFont(name: "Optima", size: 15)
          label.layer.cornerRadius = 5
          returnedView.layer.cornerRadius = 5

          
          switch section {
          
          case 0:
          label.text = "Itinerary"
//          label.underlineMyText(text: label.text!, color: .white)
              
          case 1:
              label.text = "Inclussions"
//            label.underlineMyText(text: label.text!, color: .white)

              
          case 2:
              label.text = "Exclussions"
//              label.underlineMyText(text: label.text!, color: .white)

          
          default:
          
              label.text = ""
              
          }
          
          returnedView.addSubview(label)
                       
          return returnedView
                   
               

          
      }
          
      
      @objc func onTappedBtn(_ sender: UIButton) {

          let section = sender.tag
          sectionStats[section] = !sectionStats[section]
          dataTV.beginUpdates()
          dataTV.reloadSections([section], with: .automatic)
          dataTV.endUpdates()
          
          let img = sender.imageView?.image?.rotate(radians: .pi/4)
          sender.setImage(img, for: .normal)
      }
      


      
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
        
        if expandedIndexSet.contains(indexPath.row) {
            return 200
            
        } else {
           return 50
            }
    
        } else {
            return 35
        }
    }
}

