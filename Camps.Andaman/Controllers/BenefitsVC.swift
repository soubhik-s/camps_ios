//
//  BenefitsVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 17/11/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class BenefitsVC: UIViewController {

  
    
    @IBOutlet weak var img_View: UIImageView!
    
    @IBOutlet weak var dataTV: UITableView!
    var adultBenefits_Arr:[AdultBenefit] = []
    var childBenefits_Arr:[ChildBenefit] = []
    var inclussin_Arr:[AllInclusion] = []
    var isInclusions:Bool = false
   
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {
        dataTV.dataSource = self
        dataTV.delegate = self
        img_View.layer.cornerRadius = 10
        getBenfitsData()
        
    }
   
    
    
    
    
    @IBAction func close_Axn(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }
    
    
    @IBAction func camp_SC_Axn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            isInclusions = true
            dataTV.rowHeight = 60
            dataTV.reloadWithAnimation()
        } else {
            isInclusions = false
            
            dataTV.rowHeight = UITableView.automaticDimension
                   
            dataTV.reloadWithAnimation()
        }
        
    }
    
    
    
    
    
    func getBenfitsData()  {
                                 
         if reach.isConnectedToNetwork() == true {
          showActivityIndicator()
         
          ApiService.callPost(url: ClientInterface.benefitsUrl, params: "", methodType: "GET", tag: "Benifts", finish:finishPost)
          } else {
          popUpAlert(title: "Alert", message: "Check Internet Connection", action: .actionSheet)
          }
  
    }
                 

    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
             
          hideActivityIndicator()
          do {
          if let jsonData = data {
          let parsedData = try JSONDecoder().decode(BenefitsResponse.self, from: jsonData)
          print(parsedData)
             
            if parsedData.adultBenefits.isEmpty == false {
                         
                adultBenefits_Arr = parsedData.adultBenefits
                childBenefits_Arr = parsedData.childBenefits
                inclussin_Arr = parsedData.allInclusions
                dataTV.reloadWithAnimation()
              
          }
          } else {
              
          popUpAlert(title: "Alert", message: "Error in Connecting Server ", action: .alert)
              
          }
          } catch {
          popUpAlert(title: "Alert", message: "Failed to send Password. Try Again. ", action: .alert)
          print("Parse Error: \(error)")
          }
             
        
    }
    
    
}


extension BenefitsVC: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isInclusions == true {
            return 1
        } else {
            return 2

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isInclusions == true {
            return inclussin_Arr.count
       
        } else {
            
            if section == 1 {
                return childBenefits_Arr.count
            
            } else {
                return adultBenefits_Arr.count
            
            }
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  dataTV.dequeueReusableCell(withIdentifier: "BenefitCell", for: indexPath)
        let inclusionCell = dataTV.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if isInclusions == true {
            let cellPath = inclussin_Arr[indexPath.row]
            
            
            let itemSize:CGSize = CGSize(width: 50, height: 50)
                      UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale)
                   
            let imageRect = CGRect(x: 0, y: 0, width: 50, height: 50)
                      
            
            inclusionCell.imageView!.image?.draw(in: imageRect)
                  
            inclusionCell.imageView!.image =  UIGraphicsGetImageFromCurrentImageContext()
                      UIGraphicsEndImageContext()
                      
                      
            
            inclusionCell.textLabel?.text = " \(cellPath.title)"
            inclusionCell.imageView?.setImage(urlStr: ClientConfig.inclussionsImgUrl + cellPath.inclusionsImageLink)
            inclusionCell.imageView?.makeRound()
            
            return inclusionCell
        } else {
            if indexPath.section == 1 {
                let cellPath = childBenefits_Arr[indexPath.row]
                
                cell.textLabel?.text = "➢ \(cellPath.title)"
                cell.detailTextLabel?.text = cellPath.benefits
                
            } else {
                let cellPath = adultBenefits_Arr[indexPath.row]
                           
                         
                cell.textLabel?.text = "➢ \(cellPath.title)"
                cell.detailTextLabel?.text = cellPath.benefits
            }
            return cell

        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                
        
           let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: dataTV.frame.width , height: 25))
                
           returnedView.backgroundColor = .clear
               
                   

           let label = UILabel(frame: CGRect(x: 20, y: 0, width: returnedView.frame.width - 40, height: returnedView.frame.height))
           label.textColor = .white
           label.backgroundColor = .clear
           label.textAlignment = .center
           
           label.font = UIFont(name: "Optima", size: 17)
                
           label.layer.cornerRadius = 5
           label.clipsToBounds = true
           
        if isInclusions == false {

           
           switch section {
           
           case 0:
           label.text = " ADULT BENEFITS"
               
           case 1:
               label.text = " CHILD BENEFITS"
               
           
           default:
           
               label.text = ""
               
           }
       
        } else {
            label.text = ""

        }
           
           returnedView.addSubview(label)
                        
           return returnedView
                    
                

           
        
    }
    
    
}
