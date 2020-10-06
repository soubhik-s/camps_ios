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
    
    override func viewDidLoad() {
        super.viewDidLoad()


        viewChanges()
        
    }
    
    func viewChanges() {
        
        blogTV.isHidden = true
               
        post_TV.isHidden = true
        getData()
        
        post_TV.rowHeight = 60
        
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
        
        let cellPath = dataArr[indexPath.row]
                         
        print("BlogcellPath = \(cellPath)")
        BlogVariables.Selected_Id = cellPath.id

        print("Selected_Id = \(BlogVariables.Selected_Id)")
        if tableView == blogTV {
            
           
                   
            blogCell.date_Lbl.text = cellPath.createdAt
            blogCell.blog_Title.text = cellPath.blogTitle
            blogCell.blog_IMGView.setImage(urlStr: ClientConfig.blogIMGUrl + cellPath.primaryImage)
            blogCell.description_Lbl.text = cellPath.blogDescFirst
                   
                               
            
            
            
            return blogCell
        
        } else {
            
            postCell.imageView!.setImage(urlStr: ClientConfig.blogIMGUrl + cellPath.primaryImage)
            postCell.textLabel?.text = cellPath.createdAt + "/n \(cellPath.blogTitle)"
            postCell.imageView?.makeRound()
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
                    post_TV.reloadWithAnimation()
                
                 } else {
                   print("BlogData is EMpty ")

                   }
                }
               
               } catch {
                  print("Parse Error in Blog API: \(error)")

               }

          
       }
    
    
    
    
    
}
