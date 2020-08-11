//
//  String+Ext.swift
//  SmartBottleFeeding
//
//  Created by AnnantaSource on 7/12/1398 AP.
//  Copyright © 1398 Annanta. All rights reserved.
//
import UIKit
import Foundation

extension String {
    var isValidContact: Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
  }


    func estimated() {
        let size = CGSize.init(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: self).boundingRect(with:  size, options: options, attributes: [NSAttributedString.Key.font: UIFont(name: "Bakerville", size: 15)!], context: nil)
    }

    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }

    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.dateStyle = .short
        return dateFormatter.date(from: self) // replace Date String
    }
   func getTime() -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm:ss"
   //        dateFormatter.dateStyle = .short
           return dateFormatter.date(from: self) // replace Date String
       }
    func textWidth(text: String, font: UIFont?) -> CGFloat {
        let attributes = font != nil ? [NSAttributedString.Key.font: font] : [:]
        return text.size(withAttributes: attributes as [NSAttributedString.Key : Any]).width
    }

}


extension Date {
    
    func getOnlyDateString()-> String {
        let date = Date()
        let dateFormatter = DateFormatter()


        dateFormatter.dateFormat = "dd-MM-yyyy"
        let onlyDate = dateFormatter.string(from: date)

          print("onlyDate = \(onlyDate)")
        return onlyDate
    }
    func getCurrentTime()-> String {
         let date = Date()
         let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        let onlyTime = dateFormatter.string(from: date)
        print("onlyTime = \(onlyTime)")
        return onlyTime
    }
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
    func getComponents(dayString:UILabel,monthString:UILabel,yearString:UILabel)
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day,.month,.year], from: self)
        if let day = components.day, let month = components.month, let year = components.year {
            dayString.text = String(day)
            monthString.text = String(month)
            yearString.text = String(year)
        }
    }

}

extension UIFont {
    
    func textLength(s: String) -> CGFloat
       {
        return s.size(withAttributes: [NSAttributedString.Key.font: self]).width
       }
}
