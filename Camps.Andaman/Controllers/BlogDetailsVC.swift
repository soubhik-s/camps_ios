//
//  BlogDetailsVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 05/10/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class BlogDetailsVC: UIViewController {

    
    @IBOutlet weak var cmnt_Txt: IQTextView!
    
    @IBOutlet weak var close_Btn: UIButton!
    @IBOutlet weak var submit_Btn: UIButton!
    
    @IBOutlet var comment_View: UIView!
    @IBOutlet weak var blog_Title: UILabel!
    
    @IBOutlet weak var blogger_Name_Lbl: UILabel!
  
    @IBOutlet weak var statement_Lbl: UILabel!
  
    @IBOutlet weak var blog_IMG: UIImageView!
    
    @IBOutlet weak var description_1_Lbl: UILabel!
    
    @IBOutlet weak var description_2_Lbl: UILabel!
   
    
    @IBOutlet weak var description_3_Lbl: UILabel!
    
    @IBOutlet weak var comment_SC: UISegmentedControl!
    
    @IBOutlet weak var comment_TV: UITableView!
    
    var dataArr:BlogResponseElement!
    let cmt_View_Height:CGFloat = 250
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {

        cmnt_Txt.layer.cornerRadius = 5
        cmnt_Txt.layer.borderColor = UIColor.white.cgColor
        cmnt_Txt.layer.borderWidth = 0.5
        
        comment_View.layer.cornerRadius = 5
        submit_Btn.layer.cornerRadius = 10
        blog_IMG.layer.cornerRadius = 10
        getBlogData()
    }
    
    
    
    @IBAction func submit_Axn(_ sender: UIButton) {
        if cmnt_Txt.text != "" {
            postCommentData()
        } else {
            popUpAlert(title: "Alert", message: "Enter Comment", action: .alert)
        }
    }
    
    
    @IBAction func back_Axn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func comments_SC_Axn(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            showViewFromTop(View: comment_View, height: cmt_View_Height)
        } else {
            comment_TV.reloadData()
        }
    }
    
    
    @IBAction func close_Btn_Axn(_ sender: UIButton) {
        comment_SC.selectedSegmentIndex = 0
        comment_TV.reloadData()
        hideTopView(View: comment_View, height: cmt_View_Height)
    }
    
    
    
    func getBlogData()  {
        
        if reach.isConnectedToNetwork() == true {
            self.view.showActivityIndicator()
            ApiService.callPostToken(url: ClientInterface.blogsUrl + "/\(BlogVariables.Selected_Id)", params: "", methodType: "GET", tag: "Blog", finish:finishPost)
        } else {
        self.view.makeToast("Check Internet connection")
        }
        
    }
    
    func getBlogComments()  {
        
        if reach.isConnectedToNetwork() == true {
            self.view.showActivityIndicator()
            ApiService.callPostToken(url: ClientInterface.blogCommentsUrl + "/\(BlogVariables.Selected_Id)", params: "", methodType: "GET", tag: "Blog_Comment", finish:finishPost)
        } else {
        self.view.makeToast("Check Internet connection")
        }
        
    }
    
    func postCommentData() {
        if reach.isConnectedToNetwork() == true {
            self.view.showActivityIndicator()
            let details = ["user_id":UserDetails.id, "blog_id":BlogVariables.Selected_Id, "name":UserDetails.firstName, "email":UserDetails.email, "message":cmnt_Txt.text! ] as [String:Any]
                
            ApiService.postCall(url: ClientInterface.registrationUrl, params: details, methodType: "POST", tag: "Post_Comment", finish:finishPost)
            print("details = \(details)")
            
        } else {
        self.view.makeToast("Check Internet connection")
        }
        
        
    }
    
    func finishPost (message:String, data:Data? , tag: String) -> Void {
        
        self.view.hideActivityIndicator()
        
        
        if tag == "Post_Comment" {
            
           do {
            
                if let jsonData = data {
                let parsedData = try JSONDecoder().decode(PostCommentResponse.self, from: jsonData)
                print(parsedData)
            
                    if parsedData.status == true   {
                        self.view.makeToast("Comment Posted Succesfully")
                        cmnt_Txt.text = ""
                        hideTopView(View: comment_View, height: cmt_View_Height)
                        getBlogComments()
                } else {
                    print("data is Empty")
                }
                    
                }
                
            } catch {
                print("Parse Error: \(error)")
            }
            
        } else {
       
            do {
            
                if let jsonData = data {
                let parsedData = try JSONDecoder().decode(BlogResponseElement.self, from: jsonData)
                print(parsedData)
            
                    dataArr = parsedData
                    print("Blog_Details_dataArr = \(dataArr)")
                    blog_Title.text = parsedData.blogTitle
                    blogger_Name_Lbl.text = parsedData.bloggerName
                    statement_Lbl.text = parsedData.bloggerStatement
                    blog_IMG.setImage(urlStr: ClientConfig.blogIMGUrl + parsedData.primaryImage )
                    description_1_Lbl.text = parsedData.blogDescFirst
                    description_2_Lbl.text = parsedData.blogDescSecond
                    description_3_Lbl.text = parsedData.blogDescThird
                        

                    comment_TV.isHidden = false
                    comment_TV.reloadData()
                }
                    
                
                
            } catch {
                print("Parse Error: \(error)")
            }
        
        }
       
       
    }
    

}


extension BlogDetailsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
//        if dataArr.primaryImage != "" {
//            cell.imageView?.setImage(urlStr: ClientConfig.blogIMGUrl + dataArr.primaryImage)
//
//        }
//
//        cell.textLabel?.text = "\(dataArr.blogTitle)/n\(dataArr.bloggerName)"
//
        cell.imageView?.makeRound()
        
        return cell
    }
    
    
    
    
    
    
    
    
}
