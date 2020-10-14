//
//  BlogVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 05/10/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
import SideMenu
class BlogVC: UIViewController {

    
    
    @IBOutlet weak var blogTV: UITableView!
    
    @IBOutlet weak var post_TV: UITableView!
    
    var dataArr:BlogResponse = []
    var sideManager:SideMenuManager!
    var recentPostArr:BlogResponse = []

    override func viewDidLoad() {
        super.viewDidLoad()


        viewChanges()
        
    }
    
    func viewChanges() {
        
        blogTV.isHidden = true
               
        post_TV.isHidden = true
        getData()
        blogTV.layer.cornerRadius = 5
        post_TV.layer.cornerRadius = 5

        post_TV.rowHeight = 50
        
    }

    
    @IBAction func menu_Axn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension BlogVC : UITableViewDelegate , UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
       return dataArr.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let blogCell = blogTV.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogTVCell
        let postCell = post_TV.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if tableView == blogTV {
            let cellPath = dataArr[indexPath.row]

            BlogVariables.Selected_Id = cellPath.id
            print("Selected_Id = \(BlogVariables.Selected_Id)")
            
            blogCell.date_Lbl.text = cellPath.createdAt
            blogCell.blog_Title.text = cellPath.blogTitle
            blogCell.blog_IMGView.setImage(urlStr: ClientConfig.blogIMGUrl + cellPath.primaryImage)
            blogCell.description_Lbl.text = cellPath.blogDescFirst
                   
                               
            return blogCell
        
        } else {
            let cellPath = recentPostArr[indexPath.row]

            
            if indexPath.row < 5 {
            
            postCell.textLabel?.text = cellPath.createdAt
            postCell.detailTextLabel?.text = cellPath.bloggerStatement
            postCell.imageView?.makeRound()
            postCell.imageView?.setImage(urlStr: ClientConfig.blogIMGUrl + cellPath.primaryImage)
        }
            return postCell
        }
       
        
    }
    
    
    func getData()  {
              
        if reach.isConnectedToNetwork() == true {
        
            self.view.showActivityIndicator()
           
            ApiService.callPostToken(url: ClientInterface.blogsUrl, params: "", methodType: "GET", tag: "Blog", finish:finishPost)
            
        } else {
            
            popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

               }
           
    }
    func getCommentData()  {
              
        if reach.isConnectedToNetwork() == true {
            self.view.showActivityIndicator()
           ApiService.callPostToken(url: ClientInterface.blogCommentsUrl, params: "", methodType: "GET", tag: "Blog_Comment", finish:finishPost)
            
        } else {
          popUpAlert(title: "Alert", message: "Check Internet Connection", action: .alert)

        }
           
    }

        
     
    func finishPost (message:String, data:Data? , tag: String) -> Void {

    
        self.view.hideActivityIndicator()
        
            
          
        do {
                
            if let jsonData = data {
                    
            let parsedData = try JSONDecoder().decode(BlogResponse.self, from: jsonData)
                print(parsedData)
               
            if  parsedData.isEmpty == false {
                  
                dataArr = parsedData
                print("BlogData = \(dataArr)")
                blogTV.isHidden = false
                post_TV.isHidden = false
                BlogVariables.Selected_Id = dataArr.first?.id as! String
                blogTV.reloadWithAnimation()
                   
                recentPostArr = parsedData.reversed()
                post_TV.reloadData()
                    
                
               
                } else {
                 print("BlogData is EMpty ")
                }
                    
                
            }
                
            } catch {
             print("Parse Error in Blog API: \(error)")
                
            }
        
        
          
       
    }
    
    
    
    
    
}
