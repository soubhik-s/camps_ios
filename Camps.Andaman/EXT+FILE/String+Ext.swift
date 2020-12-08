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
    
    
    
    func getNoOfYears() -> Int {
        
        let formatedStartDate = self.getDate()
        print("date = \(self)")
        let currentDate = Date()
        let onlyDate = currentDate.stripTime()
        print("only Date = \(onlyDate)")
        print("formatedStartDate = \(String(describing: formatedStartDate))")
        print("currentDate = \(currentDate)")
        if formatedStartDate != nil {
        let years = Calendar.current.dateComponents([.year], from: formatedStartDate!, to: onlyDate).year
        print("No of Years = \(String(describing: years!))")
        return years!
        } else {
            print("Unbale to convert")
            return 0
        }
    }
    
    func isValidContact() -> Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
  }

    func removeSpecialCharsFromString() -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_,")
        return self.filter {okayChars.contains($0) }
    }

    func fiterPrice() -> String {
        let okayChars = Set("1234567890")
        return self.filter {okayChars.contains($0) }
    }
    func remove(word:String) -> String {
        return self.replacingOccurrences(of: word, with: "")
    }
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
    
    func isOnlyAlphabets() -> Bool {
        let regex = "[a-zA-Z\\s]+"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
    func formJsonToArr() -> [String] {
    
    let str1 = self.removeSpecialCharsFromString()
    print("str1 = \(str1)")
    let str2 = str1.remove(word: "u2013")
    print("str2 = \(str2)")
   let str_Arr = str2.components(separatedBy: ",").filter { $0 != "" }
    print("str_Arr = \(str_Arr)")
//    print("str_ArrCount = \(str_Arr.count)")
        return str_Arr
    }
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.dateStyle = .short
//        dateFormatter.timeStyle = .medium
        let convertedDate = dateFormatter.date(from: self)
        print("convertedDate = \(String(describing: convertedDate))")
        return convertedDate
    }
   func getTime() -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:MM:SS"
   //        dateFormatter.dateStyle = .short
           return dateFormatter.date(from: self) // replace Date String
       }
    
    func convertDateFormat() -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

         let oldDate = olDateFormatter.date(from: self)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"

 
        let convertedDate = convertDateFormatter.string(from: oldDate!)
        print("convertedDate = \(String(describing: convertedDate))")

         return convertedDate
    }
   
}


extension Date {
    
    func getOnlyDateString()-> String {
        let date = Date()
        let dateFormatter = DateFormatter()


        dateFormatter.dateFormat = "YYYY-MM-dd"
        let onlyDate = dateFormatter.string(from: date)

          print("onlyDate = \(onlyDate)")
        return onlyDate
    }
    func getCurrentTime()-> String {
         let date = Date()
         let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM:SS"
        let onlyTime = dateFormatter.string(from: date)
        print("onlyTime = \(onlyTime)")
        return onlyTime
    }
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
    func getComponents(dayString:UILabel,monthString:UILabel,yearString:UILabel) {
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
    
    func textLength(s: String) -> CGFloat{
        return s.size(withAttributes: [NSAttributedString.Key.font: self]).width
    }
}
