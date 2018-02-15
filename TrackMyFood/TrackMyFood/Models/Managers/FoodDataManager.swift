//
//  FoodDataManager.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/27/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import RealmSwift

class FoodDataManager: NSObject {
    
    static let sharedInstance = FoodDataManager()
    
    private override init() {
        super.init()
    }
    
    
    /// Returns whether there exists any locally saved data
    ///
    /// - Returns: boolean representing whether there is any data.
    func dataExist() -> Bool {
        guard let realm = RealmUtils.sharedInstance.bundledRealm else {
            return false
        }
        return DBFoodDAO().hasAnyData(realm)
    }
    
    
    /// Returns tuple of optional values of food nutrition data for the given food name.
    /// In case the food with the given name does exist, nil value will be returned.
    ///
    /// - Parameter name: food name to search for
    /// - Returns: tuple of optinal values (weight, kCal, carbs, fat, protein)
    func getFoodNutrition(name: String) -> (weight: Double?, kCal: Int?, carbs: Int?, fat: Int?, protein: Int?) {
        guard let realm = RealmUtils.sharedInstance.bundledRealm else {
            return (nil, nil, nil, nil, nil)
        }
        if (DBFoodDAO().hasAnyData(realm)) {
            if let data = DBFoodDAO().getData(realm, foodName: name) {
                return (data.weight, data.kCal, data.carbo, data.fat, data.protein)
            }
        }
        return (nil, nil, nil, nil, nil)
    }
    
}
