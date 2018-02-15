//
//  FoodItemCellModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 11/25/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

class FoodItemCellModel {
    
    var foodName: String?
    var kCal: Int?
    
    var infoText: String {
        get {
            let calories = kCal ?? 0
            return String(calories) + "kCal / 1 portion (100g)"
        }
    }
    
}
