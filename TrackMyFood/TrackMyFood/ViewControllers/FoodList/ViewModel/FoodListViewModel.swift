//
//  FoodListViewModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 10/13/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

protocol FoodListViewModelProtocol: class {
    func dataModelPrepared()
}
class FoodListViewModel {
    
    weak var delegate: FoodListViewModelProtocol?
    
    var screenTitle: String {
        get { return "List" }
    }
    
    var heightForHeader: CGFloat {
        get { return 50 }
    }
    
    var heightForRow: CGFloat {
        get { return 75 }
    }
    
    var editFoodViewFrame: CGRect {
        get {
            let screenWidth = UIScreen.main.bounds.size.width
            let screenHeight = UIScreen.main.bounds.size.height
            
            let viewHeight = screenWidth * 0.85
            let viewWidth = screenWidth * 0.85
            
            let frame: CGRect = CGRect(x: (screenWidth - viewWidth) / 2,
                                       y: (screenHeight - viewHeight) / 2,
                                       width: viewWidth,
                                       height: viewHeight)
            return frame
        }
    }
    
    enum CellType {
        case foodItem
    }
    
    struct CellModel {
        var cellType: CellType?
        var data: Any?
        
        init(cellType: CellType, data: Any?) {
            self.cellType = cellType
            self.data = data
        }
    }
    
    var sections = Dictionary<Date, Array<CellModel>>()
    var sortedSections: [Date] = [Date]()
    
    func loadCells() {
        sections.removeAll()
        self.loadSavedFoodList()
    }
    
    private func loadSavedFoodList() {
        let dates = SavedFoodDataManager.sharedInstance.getSetOfAllDates(order: .orderedDescending)
        // Get for each day list of food.
        for date in dates {
            let foodItems = SavedFoodDataManager.sharedInstance.getFoodInfo(date: date)
            for foodItem in foodItems {
                // If there is no section, create new one.
                if (sections.index(forKey: date) == nil) {
                    sections[date] = [CellModel(cellType: .foodItem, data: foodItem)]
                }
                else {
                    sections[date]?.append(CellModel(cellType: .foodItem, data: foodItem))
                }
            }
        }
        self.sortedSections = Array(self.sections.keys)
    }
    
    func getModelForCell(row: Int, section: Int) -> CellModel? {
        let tableSection = self.sections[self.sortedSections[section]]
        return tableSection?[row]
    }
    
    private func notifyCompletion() {
        self.delegate?.dataModelPrepared()
    }
    
}
