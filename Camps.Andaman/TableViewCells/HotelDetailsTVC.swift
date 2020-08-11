//
//  HotelDetailsTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 08/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class HotelDetailsTVC: UITableViewCell {

    
    @IBOutlet weak var title_Lbl: UILabel!
    
    @IBOutlet weak var txt_Lbl: UILabel!
    
    @IBOutlet weak var chk_IMG: UIImageView!
    @IBOutlet weak var title_IMG: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
