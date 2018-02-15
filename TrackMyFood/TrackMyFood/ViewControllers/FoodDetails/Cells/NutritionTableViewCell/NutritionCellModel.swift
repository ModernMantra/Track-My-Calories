//
//  NutritionCellModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 11/25/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

class NutritionCellModel {
    
    public private(set) var protein: String
    public private(set) var carbo: String
    public private(set) var fat: String
    public private(set) var kCal: String
    
    init(protein: String, carbo: String, fat: String, kCal: String) {
        self.protein = protein
        self.carbo = carbo
        self.fat = fat
        self.kCal = kCal
    }
    
}
