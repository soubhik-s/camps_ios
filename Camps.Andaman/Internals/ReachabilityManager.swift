//
//  ReachabilityManager.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 28/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
import Reachability
import Network

class ReachabilityManager: NSObject {
   static  let shared = ReachabilityManager()  // 2. Shared instance
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .unavailable
    }
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.Connection = .unavailable
    // 5. Reachability instance for Network status monitoring
   
    let reachability = try! Reachability()
    
    func topMostController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }

        var topController = rootViewController

        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }

        return topController
    }
    
   

    @objc func reachabilityChanged(notification: Notification) {
       let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .cellular:
//           topMostController()?.popUpAlert(title: "Alert", message: " Internet - Cellular", action: .alert)
            print("Cellular")
        case .wifi:
//            topMostController()?.popUpAlert(title: "Alert", message: " Internet - Wifi", action: .alert)
        print("Wifi")
        case .unavailable:
           
            topMostController()?.networkAlert()
        print("UnAvailable")
            
        default:
            break
        }
    }
    
    // Starts monitoring the network availability status
    func startMonitoring() {
       NotificationCenter.default.addObserver(self,
                 selector: #selector(self.reachabilityChanged),
                 name: Notification.Name.reachabilityChanged,
                   object: reachability)
      do{
        try reachability.startNotifier()
      } catch {
        print("Could not start reachability notifier")
      }
    }
    
}
