//
//  PackageDetailsTVC.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 19/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class PackageDetailsTVC: UITableViewCell {

    @IBOutlet weak var eveningSV: UIStackView!
    
    @IBOutlet weak var nightSV: UIStackView!
    @IBOutlet weak var noonSV: UIStackView!
    @IBOutlet weak var morningSV: UIStackView!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    @IBOutlet weak var eveningLbl: UILabel!
    
    @IBOutlet weak var afterNoonLbl: UILabel!
    
    @IBOutlet weak var morningLbl: UILabel!
    
    @IBOutlet weak var nightLbl: UILabel!
    
    
    
    
    @IBOutlet weak var labelView: UIView!
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
