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
    
//    func openGallery() {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
////            imagePicker.allowsEditing = true
//            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
//            self.present(imagePicker, animated: true, completion: nil)
//        } else {
//
//            popUpAlert(title: "Alert", message: "You don't have Access", action: .alert)
//        }
//    }
    
    func openGallery() {
           
           let alertController : UIAlertController = UIAlertController(title: "Upload Image", message: "Select Camera or Photo Library", preferredStyle: .actionSheet)
           
          alertController.setTitlet(font: UIFont(name: "Raleway", size: 14), color: .red)
                
           alertController.setMessage(font: UIFont(name: "Raleway", size: 12), color: .black)

           alertController.setBackgroundColor(color: .white)
        alertController.setTint(color: .baseColor)
           
           let cameraAction : UIAlertAction = UIAlertAction(title: "Camera", style: .default, handler: {(cameraAction) in
                   print("camera Selected...")

           if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) == true {
               self.selectImageFrom(.camera)

           } else{
               self.popUpAlert(title: "Alert", message: "Camera is not available or access denied", action: .alert)

           }

           })

           let libraryAction : UIAlertAction = UIAlertAction(title: "Photo Library", style: .default, handler: {(libraryAction) in
               print("Photo library selected....")

           if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) == true {
               self.selectImageFrom(.photoLibrary)

           } else{
               self.popUpAlert(title: "Alert", message: "Libary is not available or access denied", action: .alert)

           }
           })
           
           let cancelAction : UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel , handler: {(cancelActn) in
               print("Cancel action was pressed")
           
           })

           alertController.addAction(cameraAction)
           alertController.addAction(libraryAction)
           alertController.addAction(cancelAction)
           alertController.popoverPresentationController?.sourceView = view
           alertController.popoverPresentationController?.sourceRect = view.frame

           self.present(alertController, animated: true, completion: nil)


           //        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
           //            selectImageFrom(.photoLibrary)
           //            return
           //        }
           //        selectImageFrom(.camera)
               
        
    }
    
    
    func selectImageFrom(_ source: UIImagePickerController.SourceType){
    
        let imagePicker =  UIImagePickerController()
               imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        switch source {
               case .camera:
                   imagePicker.sourceType = .camera
               case .photoLibrary:
                   imagePicker.sourceType = .photoLibrary
               case .savedPhotosAlbum:
                   imagePicker.sourceType = .savedPhotosAlbum
                default:
                   break
               }
               present(imagePicker, animated: true, completion: nil)
        
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
        if let name: String? = String(cString: (interface?.ifa_name)!), name == "en0" {
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

        if let text:String? = dateForm.string(from: current) {
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
        if let text:String? = formatter.string(from: curretTime) {
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
        
    
    
    func checkInternet() {
        let network = NetworkManager.sharedInstance
        network.reachability.whenUnreachable = { reachability in
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InternetVC") as! InternetVC
                VC.modalPresentationStyle = .fullScreen
                VC.modalTransitionStyle = .coverVertical
                self.present(VC, animated: true) {
                    
                }
                
        }
    }

    



func showViewFromTop(View:UIView, height:CGFloat) {
      let window = UIApplication.shared.keyWindow
      let transparentView = UIView()
      transparentView.tag = 9999
      transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
      transparentView.frame = window!.frame
      window!.addSubview(transparentView)
      
      let screenSize = UIScreen.main.bounds.size
      View.frame = CGRect(x: 0, y: -screenSize.height, width: screenSize.width, height: height)
      window?.addSubview(View)

      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
          transparentView.alpha = 0.5
          View.frame = CGRect(x: 0, y: 0 , width: screenSize.width, height: height)

      }, completion:nil)
  }
  
  func hideTopView(View:UIView, height:CGFloat) {
      let window = UIApplication.shared.keyWindow

      let transView = window!.viewWithTag(9999)
      transView!.removeFromSuperview()

      let screenSize = UIScreen.main.bounds.size

     UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
          View.frame = CGRect(x: 0, y: -screenSize.height, width: screenSize.width, height: height)
      }) { (true) in
          View.removeFromSuperview()

      }
  }
  
  
  func showBottomView(View:UIView, height:CGFloat) {
      
 
      let window = UIApplication.shared.keyWindow
      let transparentView = UIView()
      transparentView.tag = 999
      transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            transparentView.frame = self.view.frame
            window?.addSubview(transparentView)

      let screenSize = UIScreen.main.bounds.size
      View.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: height)
      window?.addSubview(View)

      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
          transparentView.alpha = 0.5
     
          View.frame = CGRect(x: 0, y: screenSize.height - height, width: screenSize.width, height: height)
      }, completion: nil)
      
  }
  
  
  func hideBottomView(View:UIView, height:CGFloat) {
      let window = UIApplication.shared.keyWindow

      let transView = window!.viewWithTag(999)
      transView!.removeFromSuperview()

      let screenSize = UIScreen.main.bounds.size

      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
              View.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: height)
          }, completion: nil)
      
  }
    
    func getCurrentMonth() -> Int {
        let today = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        let components = calendar.dateComponents([.month], from: today)
        let month = components.month ?? 0
        formatter.dateStyle = .short
        print(formatter.string(from: today))
        print("month = \(month)")
        return month
    }

    func getCurrentYear() -> Int {
           let today = Date()
           let calendar = Calendar.current
           let formatter = DateFormatter()
           let components = calendar.dateComponents([.year], from: today)
           let year = components.year ?? 0
           formatter.dateStyle = .short
           print(formatter.string(from: today))
           print("year = \(year)")
           return year
       }
    
    func getCurrentday() -> Int {
            
        let today = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateStyle = .short

        let components = calendar.dateComponents([.day], from: today)
        let day = components.day ?? 0
        print(formatter.string(from: today))
        print("day = \(day)")
           
        return day
         
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
