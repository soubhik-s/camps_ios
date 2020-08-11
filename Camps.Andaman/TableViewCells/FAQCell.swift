//
//  FAQCell.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 27/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class FAQCell: UITableViewCell {
    
    
    @IBOutlet weak var dataView: UIView!
    
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var IMGView: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
