//
//  BlogTVCell.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 05/10/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class BlogTVCell: UITableViewCell  {
    
    @IBOutlet weak var blog_IMGView: UIImageView!
    @IBOutlet weak var description_Lbl: UILabel!
    
    @IBOutlet weak var more_Btn: UIButton!
    @IBOutlet weak var date_Lbl: UILabel!
    @IBOutlet weak var blog_Title: UILabel!
    
    @IBOutlet weak var data_View: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        data_View.layer.cornerRadius = 5
    }
                
            
    @IBAction func more_Btn_Axn(_ sender: UIButton) {
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlogDetailsVC") as! BlogDetailsVC
        self.parentContainerViewController()?.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
        
    

}
