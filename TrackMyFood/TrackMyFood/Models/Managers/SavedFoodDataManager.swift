//
//  SavedFoodDataManager.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 10/13/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

public struct Food {
    var weight: Double?
    var kCal: Int?
    var fat: Int?
    var carbo: Int?
    var protein: Int?
    var foodName: String?
    
    init(weight: Double?, kCal: Int?, fat: Int?, carbo: Int?, protein: Int?, foodName: String?) {
        self.weight = weight
        self.kCal = kCal
        self.fat = fat
        self.carbo = carbo
        self.protein = protein
        self.foodName = foodName
    }
    
    init() {
        
    }
}

public enum TimeInterval: String {
    case today
    case week
    case month
    
    static let allValues: [TimeInterval] = [.today, .month, .week]
    
    static var count: Int { return TimeInterval.month.hashValue + 1 }
}

class SavedFoodDataManager: NSObject {
    
    static let sharedInstance: SavedFoodDataManager = {
            var manager = SavedFoodDataManager()
            return manager
    }()
    
    private override init() {
        super.init()
    }
    
    
    /// Returns number of locally saved food items.
    ///
    /// - Returns: integer value
    func getItemCount() -> Int {
        return DBSavedRecognisedFoodDAO().itemsCount()
    }
    
    
    /// Fetches from local storage saved food items for given date.
    /// For each food item gives food nutrition data represented as
    /// custom Food struct.
    ///
    /// - Parameter date: desired date to load local items
    /// - Returns: array of Food structs
    func getFoodInfo(date: Date) -> [Food] {
        var foodItems: [Food] = []
        if let data = DBSavedRecognisedFoodDAO().getFood(date: date) {
            for item in data {
                if let foodName = item.foodName {
                    let foodNutrition = FoodDataManager.sharedInstance.getFoodNutrition(name: foodName)
                    let food = Food(weight: foodNutrition.weight, kCal: foodNutrition.kCal, fat: foodNutrition.fat, carbo: foodNutrition.carbs, protein: foodNutrition.protein, foodName: item.foodName)
                    foodItems.append(food)
                }
            }
        }
        return foodItems
    }
    
    
    /// Saves locally the food with given name and date.
    ///
    /// - Parameters:
    ///   - date: date to be saved
    ///   - foodName: food name to be saved
    func insertItem(date: Date, foodName: String) {
        let data = SavedFoodTable()
        data.date = date
        data.foodName = foodName
        DBSavedRecognisedFoodDAO().insert(data: data)
    }
    
    
    /// Returns set of dates based on dates when food items are saved.
    ///
    /// - Parameter order: order at which dates will sorted
    /// - Returns: array of unique dates
    func getSetOfAllDates(order: ComparisonResult) -> [Date] {
        if let data = DBSavedRecognisedFoodDAO().getAllData() {
            var dates: [Date] = []
            for item in data {
                if let date = item.date {
                    if (!doesContaineDate(dates: dates, dateToCompare: date)) {
                        dates.append(date)
                    }
                }
            }
            return dates.sorted(by: { $0.compare($1) == order })
        }
        return [Date()]
    }
    
    func getFoodData(_ timeInterval: TimeInterval) -> [Food] {
        return [Food()]
    }
    
    // MARK: - Util
    
    /// Checks whether array of dates contains given date.
    ///
    /// - Parameters:
    ///   - dates: array of dates in which to search for
    ///   - dateToCompare: date to search in array
    /// - Returns: whether the array of dates contains given date
    private func doesContaineDate(dates: [Date], dateToCompare: Date) -> Bool {
        for date in dates {
            let order = NSCalendar.current.compare(date, to: dateToCompare, toGranularity: .day)
            if (order == .orderedSame) {
                return true
            }
        }
        return false
    }
    
}
