//
//  Elevation+Ext.swift
//  SmartBottleFeeding
//
//  Created by Idontknow on 28/11/19.
//  Copyright © 2019 Annanta. All rights reserved.
//

import Foundation
import UIKit

protocol MaterialView {
   func elevate(elevation: Double)
}

extension UIView: MaterialView {
   func elevate(elevation: Double) {
      self.layer.masksToBounds = false
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowOffset = CGSize(width: 0, height: elevation)
      self.layer.shadowRadius = CGFloat(elevation)
      self.layer.shadowOpacity = 0.24
      if elevation >= 0.0 {
       self.layer.shadowRadius = abs(CGFloat(elevation))
       } else {
       self.layer.shadowRadius = abs(CGFloat(elevation))
       }
    }
}
