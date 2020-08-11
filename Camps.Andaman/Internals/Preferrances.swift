//
//  Preferrances.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 28/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import Foundation

class Preferrences {
    
    class func setUserID(type: String) {
        UserDefaults.standard.set(type, forKey: "userID")
    }
    
    class func getUserID() -> String {
      
    if let type: String = UserDefaults.standard.string(forKey: "userID") {
    return type
    
    } else {
    return ""
    }
    
    }
    
    class func setUserIMG(type: String) {
   
    UserDefaults.standard.set(type, forKey: "user_Img")
    }
       
    class func getUserIMG() -> String {
   
    if let type: String = UserDefaults.standard.string(forKey: "user_Img") {
    return type
    
    } else {
    return ""
    }
    }
    
    
    class func setUserEmail(type: String) {
            UserDefaults.standard.set(type, forKey: "user_email")
        }
        
        class func getUserEmail() -> String {
            if let type: String = UserDefaults.standard.string(forKey: "user_email") {
                return type
            } else {
                return ""
            }
        }
        
    class func setUserPass(type: String) {
        UserDefaults.standard.set(type, forKey: "user_pass")
    }
    
    class func getUserPass() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "user_pass") {
            return type
        } else {
            return ""
        }
    }
    
    class func setRememberMe(status: Bool) {
        UserDefaults.standard.set(status, forKey: "login_status")
    }
    

    
    class func getRememberMe() -> Bool {
        let status: Bool = UserDefaults.standard.bool(forKey: "login_status")
        return status
    }
    
    class func setInstalled(status: Bool) {
        UserDefaults.standard.set(status, forKey: "is_installed")
    }
    

    
    class func getInstalled() -> Bool {
        let status: Bool = UserDefaults.standard.bool(forKey: "is_installed")
        return status
    }
        
        class func clearPreference () {
            UserDefaults.standard.removeObject(forKey: "user_name")
            UserDefaults.standard.removeObject(forKey: "password")
            UserDefaults.standard.removeObject(forKey: "isUserLogin")
            UserDefaults.standard.removeObject(forKey: "profile_id")
            UserDefaults.standard.removeObject(forKey: "first_name")
            UserDefaults.standard.removeObject(forKey: "last_name")
        }
        
        
        
        
        
    }
    
    
    
    

