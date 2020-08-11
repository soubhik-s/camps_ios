//
//  ViewCntrl+Ext.swift
//  SmartBottleFeeding
//
//  Created by AnnantaSource on 6/31/1398 AP.
//  Copyright © 1398 Annanta. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation
import LocalAuthentication
import Photos

//let reach = Reachability()
var iconClick:Bool = false

extension UIViewController {
    // open Gallery
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            
            popUpAlert(title: "Alert", message: "You don't have Access", action: .alert)
        }
    }
    // hide keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
   
    
    
   
    

    func passwordSecurity(passTF:UITextField, button:UIButton) {
    if(iconClick == false) {
    passTF.isSecureTextEntry = false
    button.setImage(UIImage(named: "close"), for: .normal)
    } else {
    passTF.isSecureTextEntry = true
    button.setImage(UIImage(named: "open2"), for: .normal)
    }
    iconClick = !iconClick
        
    }
    
    func popUpAlert(title:String, message:String, action:UIAlertController.Style) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: action)
        
        alert.setTitlet(font: UIFont(name: "Baskerville", size: 15.0), color: .red)
        alert.setMessage(font: UIFont(name: "Baskerville", size: 15.0), color: .black)
        alert.setBackgroundColor(color: .white)
        alert.view.backgroundColor = .clear
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)
        }
            
        )
    }
    func alert(message: String, title: String ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.setTitlet(font: UIFont(name: "Optima", size: 15.0), color: .red)
        alert.setMessage(font: UIFont(name: "Optima", size: 15.0), color: .black)
        alert.setBackgroundColor(color: .white)
        alert.view.backgroundColor = .clear
        alert.setTint(color: .black)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (handler) in
        
    }
        
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func networkAlert() {
        let alert = UIAlertController(title: "Alert", message: "Check Internet", preferredStyle: .alert)
            alert.setTitlet(font: UIFont(name: "Baskerville", size: 15.0), color: .red)
            alert.setMessage(font: UIFont(name: "Baskerville", size: 15.0), color: .black)
            alert.setBackgroundColor(color: .white)
            alert.view.backgroundColor = .clear
            alert.setTint(color: .black)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (handler) in
            ReachabilityManager.shared.startMonitoring()

        }
            
//            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
    }
    
    func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
        var ptr = ifaddr
        while ptr != nil {
        defer { ptr = ptr?.pointee.ifa_next }
        let interface = ptr?.pointee
        let addrFamily = interface?.ifa_addr.pointee.sa_family
        if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
        if let name: String = String(cString: (interface?.ifa_name)!), name == "en0" {
        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
        address = String(cString: hostname)
        }
        }
        }
        freeifaddrs(ifaddr)
        }
        return address
    }
    
    
    func setCurrentDate() -> String?{
        let current = Date()
        let dateForm = DateFormatter()
        dateForm.dateFormat = "yyyy-MM-dd"  // MM-dd-yyyy

        if let text:String = dateForm.string(from: current) {
         return text
        } else {
           return "Unable To Convrt setCurrentDate"
        }
        
    }
    
    func setCurrentTime()-> String? {
        
        let curretTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        if let text:String = formatter.string(from: curretTime) {
            return text
        } else {
            return "Unable To Convrt setCurrentTime"
        }
    }
    
    func showActivityIndicator() {
        
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        activityIndicator.backgroundColor = .clear
        activityIndicator.layer.cornerRadius = activityIndicator.frame.height / 2
//        activityIndicator.layer.cornerRadius = 6
//    self.view.addBlurEffect()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = .white
        activityIndicator.tag = 111
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        let activityIndicator = self.view.viewWithTag(111) as? UIActivityIndicatorView
//        self.view.removeBlurEffect()
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
        
    
    
    

    
}





//MARK: CALayer

extension CALayer {
    func showBorder(){
        self.borderColor = UIColor.black.cgColor
        self.borderWidth = 1.0
        self.masksToBounds = true
        
    }
   
    
}

extension UITableViewCell {
    
    
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }
        return topMostViewController
    }
}