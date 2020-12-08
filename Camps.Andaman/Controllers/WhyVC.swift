//
//  WhyVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 17/11/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class WhyVC: UIViewController {

    @IBOutlet weak var dataTV: UITableView!
    var content_Arr:[Points] = []
    var points_Arr:[String] = []

    @IBOutlet weak var img_View: UIImageView!
    
    override func viewDidLoad() {            super.viewDidLoad()

            viewChanges()
        
    }
        

    
    func viewChanges() {
        img_View.layer.cornerRadius = 10
        dataTV.dataSource = self
        dataTV.delegate = self
        dataTV.sectionHeaderHeight = 60
       getBenfitsData()
    }
    
    
    @IBAction func closeBtn_Axn(_ sender: UIButton) {
        dismiss(animated: true) {
            
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
                    
                   
                    content_Arr = parsedData.allChooseContent
                    let pointsStr = parsedData.points.points?.removeSpecialCharsFromString()
                    points_Arr = pointsStr!.components(separatedBy: ",")
                    
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


   
extension WhyVC: UITableViewDelegate , UITableViewDataSource {
        

    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 1 {
                return points_Arr.count

            } else {
                return content_Arr.count

            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell =  dataTV.dequeueReusableCell(withIdentifier: "BenefitCell", for: indexPath)
            if indexPath.section == 1 {
                cell.textLabel?.text = "➢ \(points_Arr[indexPath.row])"
                cell.detailTextLabel?.text = ""

                
            } else {
                    
                         
                let cellPath = content_Arr[indexPath.row]
                cell.textLabel?.text = "☞ \(cellPath.title)"
                cell.detailTextLabel?.text = cellPath.pointsDescription
               
            }
            
            return cell
        }
        
        
        
      
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                    
    
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: dataTV.frame.width  , height: 60))
                    
        returnedView.backgroundColor = .clear
                   
                       

        let title_label = UILabel(frame: CGRect(x: 0, y: 0, width: returnedView.frame.width , height: 25))
        
        let subtitle_label = UILabel(frame: CGRect(x: 0, y: 25, width: returnedView.frame.width , height: 25))
        
        title_label.textColor = .white
        title_label.backgroundColor = .baseColor
        title_label.textAlignment = .center
               
        title_label.font = UIFont(name: "Optima", size: 14)
            
        subtitle_label.textColor = .white
                    
        subtitle_label.backgroundColor = .baseColor
        subtitle_label.textAlignment = .center
                          
        subtitle_label.font = UIFont(name: "Optima-Italic", size: 12)
                    
        subtitle_label.layer.cornerRadius = 5
        subtitle_label.clipsToBounds = true
        title_label.layer.cornerRadius = 5
        title_label.clipsToBounds = true


               
        
        switch section {
               
            
        case 0:
        
            title_label.text = "Why Choose us..?"
            subtitle_label.text = " We’re Islanders, We Know Andaman the Best!! "

            
        case 1:
        
            title_label.text = "Our Difference"
                                                     
            subtitle_label.text = " Find your way to enjoy the best camp in Andaman "

               
            
        default:
               
            title_label.text = ""
                                   
            subtitle_label.text = ""

            
        }
               
        
        returnedView.addSubview(title_label)
        returnedView.addSubview(subtitle_label)

                            
        
        return returnedView
                        
                
    }
        
        
        
    }
