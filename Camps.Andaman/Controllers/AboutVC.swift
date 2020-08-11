//
//  AboutVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 11/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var IMG_View: UIImageView!
    

    @IBOutlet weak var dataTV: UITableView!
    
    let sections = ["Why Andaman..?","Core Values","Leadership"]
    
    let notesArr  = ["Nowadays, students are spending more time in study related aspects. In terms of activities, it is less or can be said as completely zero. In short terms, it can be said as “less watching, relaxing, and more works.” They require some break from the external world and stay with themselves to realize their dreams, goals, and learn on their own. Andaman is a place where children’s study and practise traditional culture, arts and craftsmanship, build sandcastles, or keep themselves busy in playing with endemic species, fish, and other sea creatures.","Andaman also reflects the history of Indian independence that was studied in primary classes, know about the origin of some of the mankind and some of the tribal generations, play under the crystal clear sky and pristine beaches, reconnect with local culture and tourism, handicraft products, and much more."]
    
    let notesArr2 = ["Apart from these, our company is backed with the standard principles that represent what we are doing, and the purpose that defines “why.” The main agenda behind the company is to provide comprehensive overview about the land that is filled with natural beauties, a place that still follows the oldest traditions, housed with numerous endemic sea lives, and how best it serves the travelers with its picturesque beauty, pristine and attractive beaches that lures any person to experience the wonderful  moments.", "Furthermore, our expert team has introduced many travel service offerings that bestow to clients at its utmost level. One of them is the summer campaign in which a candidate can spend their holidays with fun and gain knowledge. The yoga and teachings from freedom fighter families empower them with the best health care practices and experiences of their life, respectively.", "Kayaking, sea boat riding rejuvenates and refreshes them from their exam mind-set. A study tour across the volcano caters to life thriller experiences. This approach can build the children's career and provide a clear picture of “what they want to become” in the near future.","Each and every step of a candidate is monitored by our trained professionals in that particular field. They will ensure that every child/adult is involved in all the recreational activities; individual counseling is conducted to understand children/adult strengths and weaknesses, and plan participant's daily schedule in such a way that it builds their self-confidence along with catering the beautiful fun-filled moments.","The specialized medical representatives are appointed to ensure candidate safety at a supreme level and provide healthcare services in every point of contact. A medical camp is conducted before selecting the candidate for camping; daily sessions about the do's and dont's are provided by medical superintendents and a package with the complete medical suite that serves the absolute necessity of the candidate's well-being."]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()


    }
    
    func viewChanges() {
        IMG_View.layer.cornerRadius = 10
        dataTV.reloadData()
        dataTV.reloadWithAnimation()
    }

    @IBAction func backAxn(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
        
//        self.navigationController?.popViewController(animated: true)
    }
    
}
extension AboutVC: UITableViewDelegate, UITableViewDataSource, DetailsDelegate {
    
    func onIndexTapped() {
        let VC = self.storyboard?.instantiateViewController(identifier: "SelfDetailsVC") as! SelfDetailsVC
    
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true) {
            
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return notesArr.count
        case 1:
            return notesArr2.count
        case 2:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = notesArr[indexPath.row]
        return cell
        
        } else if indexPath.section == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = notesArr2[indexPath.row]
        return cell
       
        } else {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "AboutCell") as! AboutTVC
            customCell.delegate = self
        return customCell
        
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
        

        
        switch section {
        
        case 0:
        label.text = "Why Andaman..?"
            
        case 1:
            label.text = "Core Values"
            
        case 2:
            label.text = "Our Team"
            
        
        default:
        
            label.text = ""
            
        }
        
        returnedView.addSubview(label)
                     
        return returnedView
                 
             

        
    }
    

    
   
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {


    if indexPath.section == 2 {
        return 220
    } else {
        return  UITableView.automaticDimension
    }



    }

}
