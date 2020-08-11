//
//  MenuTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 28/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class MenuTVC: UITableViewCell {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var dataView: UIView!
    

    @IBOutlet weak var IMGView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
