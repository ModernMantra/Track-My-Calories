//
//  DailyTableViewModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 2/10/18.
//  Copyright © 2018 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

class DailyTableViewModel: NSObject {
    
    enum CellType {
        case headerDate
        case dailyCircle
        case progressBars
    }
    
    struct CellModel {
        var height: CGFloat?
        var cellType: CellType?
        var data: Any?
        
        init(cellType: CellType, data: Any?, cellHeight: CGFloat?) {
            self.cellType = cellType
            self.data = data
        }
    }
    
    var cells: [CellModel] = [CellModel]()
    public private(set) var profileItems: (height: Double?, weight: Double?, age: Double?, isMale: Bool?)
    
    override init() {
        super.init()
        let plist = self.getStoredItems()
        self.profileItems.age = plist.age
        self.profileItems.height = plist.height
        self.profileItems.weight = plist.weight
        self.profileItems.isMale = plist.isMale
    }
    
    func loadCells() {
        cells.removeAll()
        self.loadHeaderDateCell()
        self.loadDailyCircleCell()
        self.loadProgressBarsCell()
    }
    
    private func loadHeaderDateCell() {
        cells.append(CellModel(cellType: .headerDate, data: nil, cellHeight: nil))
    }
    
    private func loadDailyCircleCell() {
        let cellModel = DailyCircleCellModel(totalConsumption: 2500, currentConsumption: 1400)
        cells.append(CellModel(cellType: .dailyCircle, data: cellModel, cellHeight: nil))
    }
    
    private func loadProgressBarsCell() {
        let cellModel = ProgressBarsCellModel(weightL: "120", weightR: "140", descriptionL: "CARBO", descriptionR: "PROTEIN", progressL: 0.75, progressR: 0.85)
        cells.append(CellModel(cellType: .progressBars, data: cellModel, cellHeight: nil))
    }
    
    private func getStoredItems() -> (height: Double?, weight: Double?, age: Double?, isMale: Bool?) {
        if let plist = Plist(name: "Profile"), let dictionary = plist.getValuesInPlistFile() {
            if let height = dictionary["HEIGHT"], let weight = dictionary["WEIGHT"], let male = dictionary["MALE"], let age = dictionary["AGE"] {
                return (height as? Double, weight as? Double, age as? Double, isMale: male as? Bool)
            }
            print(dictionary)
        }
        return (0, 0, 0, false)
    }
    
    // MARK: - Cell Management
    
    func getModelForCell(row: Int, section: Int) -> CellModel? {
        let model = self.cells[row]
        return model
    }
    
    func getCellHeight(index: Int) -> CGFloat {
        let cellModel = self.cells[index]
        guard let cellType = cellModel.cellType else {
            return 0
        }
        switch cellType {
        case .dailyCircle:
            return 240
        default:
            return 100
        }
    }
    
}
