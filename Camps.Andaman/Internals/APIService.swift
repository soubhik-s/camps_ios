//
//  APIService.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 20/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import Foundation
import UIKit

typealias Parameters = [String: String]


class ApiService: NSObject {
    
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    
    
    static func callPost(url:String, params: Any ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void) {
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = methodType
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        
        if methodType == "POST"  || methodType == "PUT" {
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
            request.httpBody = httpBody
            
        }
        DispatchQueue.global(qos: .background).async {
            var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        print(json)
                        
                    } catch {
                        print(error)
                    }
                }
                
                DispatchQueue.main.async {
                    
                    if(error != nil)
                    {
                        result.message = "Fail Error not null : \(error.debugDescription)"
                    }
                    else
                    {
                        
                        result.message = "Success"
                        result.data = data
                        result.tag = tag
                        
                    }
                    
                    finish(result)
                    
                    
                }
                
                }.resume()
            
        }
    }
    
    static func callPostToken(url:String, params: Any ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void)
    {
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = methodType

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        
        if methodType == "POST"  || methodType == "PUT" {
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
            request.httpBody = httpBody
            
        }
        DispatchQueue.global(qos: .background).async {
            var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        print(json)
                        
                    } catch {
                        print(error)
                    }
                }
                
                DispatchQueue.main.async {
                    
                    if(error != nil)
                    {
                        result.message = "Fail Error not null : \(error.debugDescription)"
                    }
                    else
                    {
                        
                        result.message = "Success"
                        result.data = data
                        result.tag = tag
                        
                    }
                    
                    finish(result)
                    
                    
                }
                
                }.resume()
            
        }
    }
    

    static func postCall(url:String, params: [String:Any] ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void) {
           
           guard let url = URL(string: url) else { return }
           var request = URLRequest(url: url)
           request.httpMethod = methodType

//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//           request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
           if methodType == "POST"  || methodType == "PUT" {
               
//               guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
            let postData = self.getPostString(params: params)
            
            request.httpBody = postData.data(using: .utf8)
               
           }
           DispatchQueue.global(qos: .background).async {
               var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
               let session = URLSession.shared
               session.dataTask(with: request) { (data, response, error) in
                   if let response = response {
                       print(response)
                   }
                   
                   if let data = data {
                       do {
                           let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                           print(json)
                           
                       } catch {
                           print(error)
                       }
                   }
                   
                   DispatchQueue.main.async {
                       
                       if(error != nil)
                       {
                           result.message = "Fail Error not null : \(error.debugDescription)"
                       }
                       else
                       {
                           
                           result.message = "Success"
                           result.data = data
                           result.tag = tag
                           
                       }
                       
                       finish(result)
                       
                       
                   }
                   
                   }.resume()
               
           }
       }
}
