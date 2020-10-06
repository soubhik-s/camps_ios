//
//  Protocols.swift
//  Camps.Andaman
//
//  Created by AnnantaSource on 15/05/20.
//  Copyright © 2020 ArSquareDevlopment. All rights reserved.
//

import Foundation



protocol CampsDelegate:class {
func cellTapped()
}



protocol GestureDelegate:class {
func onGestureItemTapped()
}
protocol CampingDelegate:class {
func onItemTapped()
}

protocol DetailsDelegate:class {
func onIndexTapped()
}

protocol BlogDelegate:class {
func onBlogSelected()
}
