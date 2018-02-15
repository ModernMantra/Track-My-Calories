//
//  FoodDetailsViewModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/26/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

class FoodDetailsViewModel {
    
    enum CellType {
        case image
        case hashTags
        case nutrition
        case saveButton
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
    
    func loadCells() {
        cells.removeAll()
        self.loadImageCell()
        self.loadNutritionCell()
        self.loadHashTagsCell()
        self.loadSaveButtonCell()
    }
    
    func getCellHeight(index: Int) -> CGFloat {
        let cellModel = self.cells[index]
        guard let cellType = cellModel.cellType else {
            return 0
        }
        switch cellType {
        case .image:
            return 250
        case .hashTags:
            return 85
        case .nutrition:
            return 180
        case .saveButton:
            return 80
        }
    }
    
    private func loadImageCell() {
        cells.append(CellModel(cellType: .image, data: self.getImage(), cellHeight: 250))
    }
    
    private func loadHashTagsCell() {
        let hashTags = getHashTags()
        cells.append(CellModel(cellType: .hashTags, data: HashTagsCellModel(hashTags: hashTags), cellHeight: 85))
    }
    
    private func loadNutritionCell() {
        let nutritionData = self.getNutritionData()
        let model = NutritionCellModel(protein: nutritionData.protein, carbo: nutritionData.carbs, fat: nutritionData.fat, kCal: nutritionData.kCal)
        cells.append(CellModel(cellType: .nutrition, data: model, cellHeight: 180))
    }
    
    private func loadSaveButtonCell() {
        cells.append(CellModel(cellType: .saveButton, data: nil, cellHeight: 80))
    }
    
    // MARK: - Data Retrieval/Preparation
    
    func getImage() -> UIImage? {
        let image: UIImage? = PhotoRecognitionStateModel.sharedInstance.foodImage
        return image
    }
    
    func getHashTags() -> [String] {
        let hashTags: [String] = ["  #pizza  ", "  #salmon  ", "  #applePie  ", "  #ribbs  ", "  #baklava  "]
        return hashTags
    }
    
    func getNutritionData() -> (weight: String, kCal: String, carbs: String, fat: String, protein: String)  {
        if let name = PhotoRecognitionStateModel.sharedInstance.recognizedFoodName {
            let data = FoodDataManager.sharedInstance.getFoodNutrition(name: name)
            return (String(describing: data.weight), String(describing: data.kCal), String(describing: data.carbs), String(describing: data.fat), String(describing: data.protein))
        }
        return ("", "", "", "", "")
    }
    
    func getModelForCell(row: Int, section: Int) -> CellModel? {
        let model = self.cells[row]
        return model
    }
    
    // MARK: - Save
    
    func saveRecognisedFood() {
        if let foodName = PhotoRecognitionStateModel.sharedInstance.recognizedFoodName {
            SavedFoodDataManager.sharedInstance.insertItem(date: Date(), foodName: foodName)
        }
    }
    
}
