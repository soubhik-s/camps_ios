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

    @IBOutlet weak var by_Author_Lbl: UILabel!
    
    @IBOutlet weak var blog_Title_Lbl: UILabel!
    @IBOutlet weak var cmnt_Txt: IQTextView!
    
    @IBOutlet weak var close_Btn: UIButton!
    @IBOutlet weak var submit_Btn: UIButton!
    
    @IBOutlet var comment_View: UIView!
    @IBOutlet weak var cmnt_subView: UIView!
    
  
    @IBOutlet weak var blog_IMG_CV: UICollectionView!
    
   
    @IBOutlet weak var blog_TV: UITableView!
    @IBOutlet weak var comment_SC: UISegmentedControl!
    
    @IBOutlet weak var comment_TV: UITableView!
    var des_Arr:[String] = []
    var IMG_Arr:[String] = []
    let cmt_View_Height:CGFloat = 250
    var comment_Arr:CommentResponse = []
    let blogImg_Url = "https://camps.goexploreandaman.com/assets/img/blogging/"
    var timer = Timer()
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChanges()
    }
    

    func viewChanges() {
        checkInternet()

        CVChanges()
        blog_TV.isHidden = true
        cmnt_Txt.layer.cornerRadius = 3
        cmnt_Txt.layer.borderColor = UIColor.baseColor.cgColor
        cmnt_Txt.layer.borderWidth = 0.5
        submit_Btn.layer.cornerRadius = 5
        comment_TV.layer.cornerRadius = 10
        getBlogData()
        blog_TV.rowHeight = UITableView.automaticDimension
        cmnt_subView.layer.cornerRadius = 5
    
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        
        }
               
    }
           
       
    @objc func changeImage() {
           
        if counter < IMG_Arr.count {
               let index = IndexPath.init(item: counter, section: 0)
               self.blog_IMG_CV.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
               counter += 1
        
        } else {
               counter = 0
               let index = IndexPath.init(item: counter, section: 0)
               self.blog_IMG_CV.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               counter = 1
           }
               
         
    }
    
    func CVChanges() {
        let cellSize = CGSize(width:self.view.frame.width - 20 , height:200)
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal //.horizontal
           layout.itemSize = cellSize
           layout.minimumLineSpacing = 10.0
           layout.minimumInteritemSpacing = 1.0
           blog_IMG_CV.setCollectionViewLayout(layout, animated: true)
           blog_IMG_CV.delegate = self
           blog_IMG_CV.dataSource = self
           blog_IMG_CV.showsHorizontalScrollIndicator = false
               
           
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
            if Preferrences.getUserLogin() == true {
                showViewFromTop(View: comment_View, height: cmt_View_Height)

            } else {
                popUpAlert(title: "Alert", message: "Login to Comment", action: .alert)
            }
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
            ApiService.callPostToken(url: ClientInterface.blogCommentsUrl + "/\(BlogVariables.Selected_Id)" , params: "", methodType: "GET", tag: "Blog_Comment", finish:finishPost)
        } else {
        self.view.makeToast("Check Internet connection")
        }
        
    }
    
    func postCommentData() {
        if reach.isConnectedToNetwork() == true {
            self.view.showActivityIndicator()
            let details = ["user_id":Preferrences.getUserID(), "blog_id":BlogVariables.Selected_Id, "name":Preferrences.getFirstName(), "email":Preferrences.getUserEmail(), "message":cmnt_Txt.text! ] as [String:Any]
                
            ApiService.postCall(url: ClientInterface.blogCommentsUrl, params: details, methodType: "POST", tag: "Post_Comment", finish:finishPost)
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
                    comment_SC.selectedSegmentIndex = 0
                    getBlogComments()
                
                } else {
                  self.view.makeToast(parsedData.message)
                }
                    
                }
                
            } catch {
                print("Parse Error: \(error)")
            }
            
        } else if tag == "Blog" {
       
            do {
            
                if let jsonData = data {
                let parsedData = try JSONDecoder().decode(BlogListResponseElement.self, from: jsonData)
                print(parsedData)
                    
                    IMG_Arr.append(parsedData.primaryImage)
                    IMG_Arr.append(parsedData.secondaryImage)

                    blog_Title_Lbl.text = parsedData.blogTitle
                    by_Author_Lbl.text = "by: \(parsedData.bloggerName)"
                    
//                    des_Arr.append(parsedData.blogTitle)
//                    des_Arr.append(parsedData.bloggerName)
                    des_Arr.append(parsedData.blogHeaderContent)
                    des_Arr.append(parsedData.blogDescFirst)
                    des_Arr.append(parsedData.blogDescSecond)
                    des_Arr.append(parsedData.blogDescThird)
                    des_Arr.append(parsedData.blogDescFourth)
                    des_Arr.append(parsedData.blogDescFifth)
                    des_Arr.append(parsedData.blogDescSixth)
                    des_Arr.append(parsedData.blogDescSeventh)
                    des_Arr.append(parsedData.blogDescEighth)
                    des_Arr.append(parsedData.blogDescNinth)
                    des_Arr.append(parsedData.blogDescTenth)
                    des_Arr.append(parsedData.blogTitle)

                    des_Arr = des_Arr.filter({ $0 != ""})
                    IMG_Arr = IMG_Arr.filter({ $0 != ""})

                    blog_TV.isHidden = false
                    blog_IMG_CV.isHidden = false
                    blog_IMG_CV.reloadData()
                    blog_TV.reloadData()
                   
                   getBlogComments()
                }
                    
                
                
            } catch {
                print("Parse Error: \(error)")
            }
        
        } else {
            
            do {
            
                if let jsonData = data {
                         
                let parsedData = try JSONDecoder().decode(CommentResponse.self, from: jsonData)
                print(parsedData)
                       
                    if parsedData.isEmpty == false {
                        for commentData in parsedData {
                            if commentData.status == "1" {
                                comment_Arr.append(commentData)

                            }
                        }
                        comment_TV.isHidden = false
                        comment_TV.reloadWithAnimation()
                    }
                   
               

               
                }
                               
                } catch {
                print("Parse Error: \(error)")
                    
            }
            
        }
       
       
    }
    

}


extension BlogDetailsVC : UITableViewDelegate , UITableViewDataSource, UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IMG_Arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogCVCell", for: indexPath) as! BlogDetailsCVC
        
        cell.IMG_View.setImage(urlStr: blogImg_Url + IMG_Arr[indexPath.row])
        cell.IMG_View.layer.cornerRadius = 10
        cell.IMG_View.layer.masksToBounds = true
        cell.myPageCntrl.numberOfPages = IMG_Arr.count
        cell.myPageCntrl.currentPage = indexPath.row

        return cell
    }
    
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == blog_TV {
            return des_Arr.count

        } else {
            return comment_Arr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let blogCell = blog_TV.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath)
        
        
        let cell = comment_TV.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        
        if tableView == blog_TV {
            blogCell.textLabel?.text = "➣ \(des_Arr[indexPath.row].removeSpecialCharsFromString())"
            
            
           
            return blogCell
        } else {
        
        let cellPath = comment_Arr[indexPath.row]
                cell.textLabel?.text = cellPath.message
                cell.detailTextLabel?.text = cellPath.name

            
       
        
        return cell
        }
    }
    
    
    
    
    
    
    
    
}
