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

let reach = Reachability()
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
    
   
    
    // Gradient Colors of view
    func addGradientWithColor(colorTop: UIColor, colorBottom: UIColor, view:UIView){
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [colorTop.cgColor, colorBottom.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    func gradientColor(view:UIView) {
        addGradientWithColor(colorTop: UIColor(red: 0.4235294118, green: 0.2862745098, blue: 0.7215686275, alpha: 1.0), colorBottom: UIColor.init(red: 58/255 , green: 191/255, blue: 163/255, alpha: 1.0), view: view)
        
    }
   
    

    func passwordSecurity(passTF:UITextField, button:UIButton) {
    if(iconClick == false) {
    passTF.isSecureTextEntry = false
    button.setImage(UIImage(named: "open2"), for: .normal)
    } else {
    passTF.isSecureTextEntry = true
    button.setImage(UIImage(named: "close2"), for: .normal)
    }
    iconClick = !iconClick
        
    }
    
    
    
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }
        return topMostViewController
    }
    
    
    
   
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // picker view Color and Text
    func pickerViewFunc(PV:UIPickerView, textF:UITextField) {
        PV.setValue(UIColor.white, forKey: "backgroundColor")
        PV.setValue(UIColor(red: 0.4235294118, green: 0.2862745098, blue: 0.7215686275, alpha: 1.0), forKey: "textColor")
        PV.delegate = self as? UIPickerViewDelegate
        textF.inputView = PV
    }
    
    
    // alerts
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
        alert.setTitlet(font: UIFont(name: "Baskerville", size: 15.0), color: .red)
        alert.setMessage(font: UIFont(name: "Baskerville", size: 15.0), color: .black)
        alert.setBackgroundColor(color: .white)
        alert.view.backgroundColor = .clear
        alert.setTint(color: .black)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (handler) in
            
    }
        
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
   
    func showText(inputTxt:String) {
        
 
        let textL = UILabel()
        textL.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 10 , height:80)
        textL.center = self.view.center
        textL.font = UIFont(name: "Baskerville", size: 15)
        textL.text = inputTxt
        textL.numberOfLines = 0
        textL.textColor = .black
        textL.backgroundColor = .white
        textL.layer.cornerRadius = 10
        textL.textAlignment = .center
        textL.adjustsFontSizeToFitWidth = true
//        textL.sizeToFit()
        textL.elevate(elevation: 5.0)

        self.view.addSubview(textL)

        print("printing Text")

        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (Timer) in
            textL.removeFromSuperview()
            print("Remove Text")

        }
    }
    
    
  
    
   
    
   

//MARK: conversion of date in to age
func getBabyAge (stDate:String,ageLabel:UILabel)     {
    let startDate = stDate
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    if  let formatedStartDate = dateFormatter.date(from: startDate){
        let currentDate = Date()
        let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .month, .year])
        let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate, to: currentDate)
        ageLabel.text = "Your Baby is \(String(describing: differenceOfDate.year!)) years  \(String(describing: differenceOfDate.month!)) months \(String(describing: differenceOfDate.day!)) days Old"
        print (differenceOfDate)

    }
    else {
        // yyyy-MM-dd
        print("\(startDate) cant be turned")
       }
  }
    func getTotalDays(stDate:String, daysLbl:UILabel) {
        let startDate = stDate
        let formatedStartDate = startDate.getDate()
        let currentDate = Date()
        let onlyDate = currentDate.stripTime()
        print("only Date = \(onlyDate)")
        print("formatedStartDate = \(formatedStartDate)")
        print("currentDate = \(currentDate)")
    let days = Calendar.current.dateComponents([.day], from: onlyDate , to: formatedStartDate!).day
        
        print("days = \(String(describing: days!))")
            
        if days! < 0
            {
                daysLbl.text = "Completed"
            } else
             {
                daysLbl.text = "\(String(describing: days!))"
             }
        
 
    }
    
    func getSleepDays(stDate:String,textLbl:UILabel) {
          let startDate = stDate
          let formatedStartDate = startDate.getDate()
          let currentDate = Date()
          let onlyDate = currentDate.stripTime()
          print("only Date = \(onlyDate)")
          print("formatedStartDate = \(formatedStartDate)")
          print("currentDate = \(currentDate)")
          let days = Calendar.current.dateComponents([.day], from: formatedStartDate!, to: onlyDate).day
              print("days = \(String(describing: days!))")
              textLbl.text = "\(days!) days"
          
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
    
    
    
    func homeData(nameLbl:UILabel,ageLbl:UILabel ) {
    nameLbl.text = homeViewData.getHomeName()
    ageLbl.text = homeViewData.getHomeAge()
  
    }
    
    
    func localAuthentication() {
        print("hello there!.. You have clicked the touch ID")
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
        if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
        myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
        DispatchQueue.main.async {
        if success {
        print("Local Succes")
        } else {
        print("User didnot eval")
//                        self.successLabel.text = "Sorry!!... User did not authenticate successfully"
        }
        }
        }
        } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
        print("Could not evaluate")
//       successLabel.text = "Sorry!!.. Could not evaluate policy."
        }
        } else {
            // Fallback on earlier versions
        print("This feauture is not Supported")
            
//       successLabel.text = "Ooops!!.. This feature is not supported."
        }
        
        
    }
    func getBMI(strWeight:String,strHeight:String) -> Float {
        let weightInKg = Float(strWeight)! * 0.453592
        let heightInMet = Float(strHeight)! * 0.01
        if  let BMI:Float = weightInKg/(heightInMet * heightInMet) {
            print("BMI = \(BMI)")
            return BMI
        } else {
            return 0.00
        }
    }
    
    func getWeightPercent(weight:Float)-> Float {
        let newWeight = Double(weight)
        let oldWeight = Double(homeViewData.getHomeWeight())
        let diffWeight = ((newWeight) - (oldWeight!)) / (oldWeight!)
        let wPercent:Float = Float(diffWeight * 100.0)
         return wPercent
    }
    func getHeightPercent(height:Float)-> Float {
        let newHeight = Double(height)
        let oldHeight = Double(homeViewData.getHomeHeight())
        let diffHeight = ((newHeight) - (oldHeight!)) / (oldHeight!)
        let hPercent:Float = Float(diffHeight * 100.0)
        return hPercent
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
    
    func getTimeDiff(str1:String,str2:String) -> String? {
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let time1 = format.date(from: str1)
        print("time1 = \(String(describing: time1))")
        let time2 = format.date(from: str2)
        print("time2 = \(String(describing: time2))")
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour]
        let hrs = formatter.string(from: time1!, to: time2!)
        print("hrs = \(hrs ?? "")")
        formatter.allowedUnits = [.minute]

        let min = formatter.string(from: time1!, to: time2!)
        print("min = \(String(describing: min))")
        
        formatter.allowedUnits = [.second]
        let sec = formatter.string(from: time1!, to: time2!)
        
        let text = "\(hrs!) hrs: \(min!) min "
        print("timeText = \(text)")

        return text
    }
    

    
    
    

    func showActivityIndicator() {
        
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.backgroundColor = .clear
        activityIndicator.layer.cornerRadius = 6
//    self.view.addBlurEffect()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = .black
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
