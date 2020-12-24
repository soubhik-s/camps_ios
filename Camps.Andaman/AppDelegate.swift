//
//  AppDelegate.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 05/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var rootViewController : UIViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

       


        FirebaseApp.configure()
        setupKeyboardManager()
//      MARK:Network Monitor
//        ReachabilityManager.shared.startMonitoring()
        UILabel.appearance(whenContainedInInstancesOf:[UISegmentedControl.self]).numberOfLines = 0
       
        UISegmentedControl.appearance().setTitleTextAttributes([ NSAttributedString.Key.font: UIFont(name: "Optima", size: 14)! ], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Camps_Andaman")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
              
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate {
    
    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.previousNextDisplayMode = .default
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

    }
    
     func NextViewController(storybord_Id:String) {

           let story = UIStoryboard(name: "Main", bundle: nil)
           let rootViewController = story.instantiateViewController(withIdentifier: storybord_Id)
           
           let navigationController = UINavigationController(rootViewController: rootViewController)
           navigationController.navigationBar.isHidden = true
        
           self.window = UIWindow(frame: UIScreen.main.bounds)
           self.window?.rootViewController = navigationController
           self.window?.makeKeyAndVisible()
        print("storybord_Id = \(storybord_Id)")

       }
    
}
