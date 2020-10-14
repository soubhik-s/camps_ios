//
//  CovidVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 13/10/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class CovidVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    

    
    @IBOutlet weak var dataTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    
    
    func viewChanges() {
        dataTV.delegate = self
        dataTV.dataSource = self
        dataTV.reloadWithAnimation()
    }

    @IBAction func back_Axn(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }
    
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    return cell
  }
  

}
