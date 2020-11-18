//
//  FAQViewController.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 27/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var IMG_View: UIImageView!
    

    @IBOutlet weak var dataTV: UITableView!
    
    let title_List = ["1. How do I get registered to the summer camp? ","2. What is the maximum age limit to participate in summer camp? ","3. Where exactly is the summer camp conducted?","4. What is the maximum number of camping days? ","5. Which type of food is served during a stay?","6. What can we expect during camping? ","7. What is the size of each summer camp batch? ","8. What does the camper need to bring for camping? ","9. Any preparation or training is required before entering the camp? ","10. When are the program check-in and pick-up times?","11. Whether the participant is allowed to contact their parents inside the camp? ", "12. What can we expect during camping? " , "13.What is the background and experience of camp directors? ", "14. What makes the camp different? ", "15. Does the camp offer discount? " , "16. I am concerned about my child. Is the camp director available by phone? ", "17. What are the types of food served at camp? ", "18. Will the camp be transporting kids to and from the camp location and another location? ", "19. Can my camper make own hours in order to attend other activities?  ", "20. Will camper receive any certificate? ", "21. Is the camp focused on fun or skill-building? ", "22. How much camper-to-camper interaction will there be? ", "23. Are counselors trained or do they just show up to camp the first day?  ", "24. Is there a camp nurse in attendance?  " , "25.How does the camp handle food allergies and medication? ","26.Are sleeping spaces comfortable?  "]
    
    let content_List  = ["The overall registration process is simple. You have to complete the form with your name, contact details, number of persons attending the summer camp, age, and best time to get in touch. One of our executives will contact you to provide a complete overview of the events and pricing structure.","The participants are divided on the basis of their age group. In order to ensure safety, the smallest age group considered for this event is 14, and the maximum is 35. ","During this event, we will try to cover most of the unique and picturesque locations in Andaman and Nicobar Island. Since the event also encompasses trekking and visiting numerous places, there is no particular stay in one place, but it will be organized in reputed lodging.","It will be 21 days.","Most of the time, it will be greenery and vegetarian food. Along with that, non-veg food is also served to keep children strong and healthy.","Morning yoga, meditation sections, swimming, snorkeling, boat ride, trekking, a night stay in the Jungle, study tour across Barren Island and Mud volcano, meeting with freedom fighter family, and much more in the list.","Presently, forty members are expected in a single batch, which is further divided into different groups. Each group is monitored and handled by a single counsellor/group leader.","Once the camper is registered and undergone the on-site medical test, an email will be sent to the respective persons with a detailed packing list. It may vary as per the program, and the backpack will be selected as per the weather and outdoor activity.","No! We don't expect any training session from participants. But, they have to submit their health concern certificate and participate in the health camp conducted by our team.","The detailed itinerary details will be mailed to the participants' email and a hard copy, which contains all the details regarding summer camp, is provided once they book or enter the campsite.","Yes, we will allow contacting the parents once a day. During emergency conditions, permission is provided to increase the contact number and report the status to parents on a timely basis.", "There are lot of activities for adults and child. You can have a look into our itinerary to detailed information.", "Our camp has good background in tourism section. We’re basically islanders, our camp directors are tourism graduates and bagged enough experience and knowledge about camping Andaman as well.  ","This camp is best to detox your college/work stress. Our camp is educational, fun and worth living in organic life. The city life we all live are in blues, city itself is polluted, noised in traffic and hectic living. This camp offers best opportunity to escape into nature, Meditate, learn and explore your best life here. "," Everyone loves to save.  We do have early bird offers, Earlier register, better the discount. ", "Our counsellors who lead the batches are available. Contact will be permitted only in case of emergency.  ",  "We serve healthy and high nutritious vegan food, and to add more cheer to tummy, we will add nonveg to your appetite." , "Yes, just leave the safety to us. We will transport them safely, We will make sure the child is looked after well from Port Blair airport till he/she reaches their home place", "No, as the camping happens in batches and its 12 days of camp. We have our schedules given to campers; they have to strictly follow it.  We will make sure all the fun activities camper will enjoy.  " , " Yes, Campers will receive certificates of beach yoga and meditation from experts. ", "The camps are equally created. The main aim is to experience the real organic living and also earn better survival skills in the competitive world.", "Team work is important, our activities are planned in such a way, each camper is made to come out of comfort zone and interact and blend in with each other. ", "Our camp counselors be with campers from day 1, They will ensure each camper safety until the last day of the camp.", "We have all our backed-up measures, Safety is our priority.  ","Inform beforehand about the food allergies, we will make sure that camper is taken extra care. We also have our health care department for better precautions." ,  "Campers will be allotted rooms in a resort. Room is comfortable and luxurious. "]
    
    var expandedIndexSet : IndexSet = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    func viewChanges() {
        IMG_View.layer.cornerRadius = 10
        dataTV.reloadWithAnimation()
        print("TitleCount = \(title_List.count)")
       print("contentCount = \(content_List.count)")

    }

    
    @IBAction func backAxn(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
    }
    
    
    
//    MARK: Tableview Data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return title_List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FAQCell
        cell.labelView.layer.cornerRadius = 10
        cell.titleLbl.text = title_List[indexPath.row]
        cell.contentLbl.text = content_List[indexPath.row]
       
        if expandedIndexSet.contains(indexPath.row) {
        cell.IMGView.image = UIImage(named: "up_clr")
        } else {
        cell.IMGView.image = UIImage(named: "down_clr")
        }

        cell.contentLbl.sizeToFit()
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if expandedIndexSet.contains(indexPath.row) {
            return 140
        } else {

            return 50
        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if(expandedIndexSet.contains(indexPath.row)){

           
            expandedIndexSet.remove(indexPath.row)
        } else {
            expandedIndexSet.insert(indexPath.row)
        }
        
        tableView.reloadRows(at: [indexPath], with: .fade)

        }
    
    
    
}
