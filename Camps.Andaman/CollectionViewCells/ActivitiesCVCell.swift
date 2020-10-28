//
//  ActivitiesCVCell.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 30/06/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import UIKit

class ActivitiesCVCell: UICollectionViewCell {
    
    @IBOutlet weak var data_View: UIView!
    
    
    @IBOutlet weak var itinerary_Lbl: UILabel!
    @IBOutlet weak var night_Lbl: UILabel!
    @IBOutlet weak var eve_Lbl: UILabel!
    @IBOutlet weak var noon_Lbl: UILabel!
    @IBOutlet weak var mrng_Lbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var title_Lbl: UILabel!
    
    
    
    override var isSelected: Bool {
             
        didSet {
        
            self.title_Lbl.textColor = isSelected ? UIColor.white : UIColor.baseColor

            self.data_View.backgroundColor = isSelected ? UIColor.baseColor : UIColor.white
            self.data_View.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.baseColor.cgColor
                    
        }
               }
}
