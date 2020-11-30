//
//  SceneDelegate.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 05/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
         IQKeyboardManager.shared.enable = true
//         Thread.sleep(forTimeInterval: 3.0)

//        MARK: set Root Navigation Controller
        guard let winScene = (scene as? UIWindowScene) else { return }
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
           
            if Preferrences.getInstalled() == true {
                let Home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as! ViewController
                let navigation = UINavigationController(rootViewController: Home)
                navigation.navigationBar.isHidden = true
                window.rootViewController = navigation

            } else {
                let Home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SlidesVC") as! SlidesVC
                let navigation = UINavigationController(rootViewController: Home)
                navigation.navigationBar.isHidden = true
                window.rootViewController = navigation

            }
           
            self.window = window
            window.makeKeyAndVisible()
        
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

