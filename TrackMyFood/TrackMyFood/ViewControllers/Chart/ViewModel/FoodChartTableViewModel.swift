//
//  FoodChartViewModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/24/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

protocol FoodChartModelDelegate: class {
    func notifyCompletion()
}

class FoodChartTableViewModel {
    
    enum CellType {
        case chart
        case segmentedControl
        case quote
        case progressBar
    }
    
    struct CellModel {
        var height: CGFloat {
            get {
                switch self.cellType {
                case .chart:
                    return 220
                case .segmentedControl:
                    return 50
                case .quote:
                    return 80
                case .progressBar:
                    return 200
                }
            }
        }
        var cellType: CellType
        var data: Any?
        
        init(cellType: CellType, data: Any?) {
            self.cellType = cellType
            self.data = data
        }
    }
    
    var screenTitle: String {
        get { return "Chart" }
    }
    
    var cells: [CellModel] = [CellModel]()
    public private(set) var chartState: TimeInterval = TimeInterval.today
    weak var delegate: FoodChartModelDelegate?
    
    func loadCells() {
        self.cells.removeAll()
        self.loadChart()
        self.loadSegmentedControl()
        self.loadProgressBar()
        self.loadQuote()
        self.delegate?.notifyCompletion()
    }
    
    // MARK: - Chart Component
    
    // Will load the chart based on state set in chartState
    private func loadChart() {
        switch self.chartState {
        case .month:
            self.loadMonthlyChart()
        case .today:
            self.loadTodayChart()
        case .week:
            self.loadWeeklyChart()
        }
    }
    
    private func loadTodayChart() {
        let numbers: [Double] = [350, 128, 170, 45, 30]
        let xValues: [String] = ["1PM", "2PM", "3PM", "4PM", "5PM"]
        let chartModel = ChartViewModel(dataSet: numbers, xValues: xValues)
        self.cells.append(CellModel(cellType: .chart, data: chartModel))
    }
    
    private func loadWeeklyChart() {
        let numbers: [Double] = [1230, 1280, 2300, 1570, 1790, 1870, 2300]
        let xValues: [String] = ["3rd", "4th", "5th", "6th", "7th", "8th"]
        let chartModel = ChartViewModel(dataSet: numbers, xValues: xValues)
        self.cells.append(CellModel(cellType: .chart, data: chartModel))
    }
    
    private func loadMonthlyChart() {
        let numbers: [Double] = [123.0, 350.0, 65.0, 40.0, 457.0, 67.0]
        let xValues: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let chartModel = ChartViewModel(dataSet: numbers, xValues: xValues)
        self.cells.append(CellModel(cellType: .chart, data: chartModel))
    }
    
    func setChartState(_ state: Int) {
        let lookingForRange = TimeInterval.count
        guard lookingForRange ~= lookingForRange else {
            return
        }
        switch state {
        // TODAY
        case 0:
            self.chartState = .today
        // WEEK
        case 1:
            self.chartState = .week
        // MONTH
        case 2:
            self.chartState = .month
        default:
            break
        }
    }
    
    // MARK: - Segmented control component
    
    private func loadSegmentedControl() {
        let segmentsTitles = TimeInterval.allValues.map({ $0.rawValue })
        let segmentModel = SegmentsCellModel(segmentedControlTitles: segmentsTitles)
        self.cells.append(CellModel(cellType: .segmentedControl, data: segmentModel))
    }
    
    // MARK: - Quote component
    
    private func loadQuote() {
        let message: String = "You risk nothing, you gain nothing"
        let model = QuoteCellModel(message: message)
        self.cells.append(CellModel(cellType: .quote, data: model))
    }
    
    // MARK: - Progress Bar Component
    
    private func loadProgressBar() {
        let proteinConsumption: [Double] = []
        let carbConsumtpion: [Double] = []
        let fatConsumption: [Double] = []
        let model = ProgressBarCellModel(proteinConsumption: proteinConsumption, carbConsumption: carbConsumtpion, fatConsumption: fatConsumption)
        self.cells.append(CellModel(cellType: .progressBar, data: model))
    }
    
    func getModelForCell(row: Int, section: Int) -> CellModel? {
        let model = self.cells[row]
        return model
    }

}
