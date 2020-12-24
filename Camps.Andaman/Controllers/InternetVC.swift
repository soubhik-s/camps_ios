//
//  InternetVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 24/12/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class InternetVC: UIViewController {
    let network = NetworkManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()


        
        network.reachability.whenReachable = { reachability in
            self.dismiss(animated: true, completion: {
                
            })
        }
    }
    
    @objc func receivedConnection() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
