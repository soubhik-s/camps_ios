//
//  ActivitiesVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 15/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class ActivitiesVC: UIViewController {

 
    @IBOutlet weak var dataTV: UITableView!
    var dataArray:[ItineraryResponseElement] = []
    var days_Arr = ["Day 1"," Day 2"," Day 3"," Day 4"," Day 5"," Day 6"," Day 7","# Day 8"," Day 9"," Day 10"," Day 11", " Day 12" ]
    var iti_Arr = [""]
    var morning_Arr = [""]
    var noon_Arr = [""]
    var eve_Arr = [""]
    var night_Arr = [""]
    var expandedIndexSet : IndexSet = []

    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    func viewChanges() {
        checkInternet()

        dataTV.isHidden = true
        getData()
    }

    
    
    @IBAction func back_Axn(_ sender: UIButton) {
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
        let parsedData = try JSONDecoder().decode(ItineraryResponseElement.self, from: jsonData)
        print(parsedData)
        dataArray = [parsedData]
            print("dataArray = \(dataArray)")

            dataTV.isHidden = false
            dataTV.reloadWithAnimation()
                    
        } else {
            popUpAlert(title: "Alert", message: "Error in Connecting Server", action: .alert)
        }
            
        } catch {
        alert(message: "Alert", title: "No Data from Server")
        print("Parse Error: \(error)")
                
        }
        
    }
   

}
extension ActivitiesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PackageDetailsTVC
        
        let cellPath = dataArray[indexPath.row]
        cell.titleLbl.text = cellPath.itienaryName?[indexPath.row]
        cell.morningLbl.text = cellPath.morningActivity?[indexPath.row]
        cell.afterNoonLbl.text = cellPath.afterNoonActivity[indexPath.row]
        cell.eveningLbl.text = cellPath.eveningActivity[indexPath.row]
        cell.nightLbl.text = cellPath.overNightActivity[indexPath.row]
        cell.labelView.makeRound()


        
        if expandedIndexSet.contains(indexPath.row) {
        cell.IMGView.image = UIImage(named: "up_clr")
        } else {
        cell.IMGView.image = UIImage(named: "down_clr")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if(expandedIndexSet.contains(indexPath.row)){

               expandedIndexSet.remove(indexPath.row)
           } else {
           expandedIndexSet.insert(indexPath.row)
           }
                  
           tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
         
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
        if expandedIndexSet.contains(indexPath.row) {
        
        return 200
        } else {
        return 50
            
        }
    }
        
}
