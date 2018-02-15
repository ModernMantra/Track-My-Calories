//
//  ChartViewModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 11/25/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import Charts

class ChartViewModel {
    
    // Array of numbers that will be presented on the chart
    public private(set) var numbers: [Double]?
    
    // Array of data to be drawn on the chart (numbers converted to ChartDataEntry), recognizable by Chart component
    public private(set) var lineChartDataEntry: [ChartDataEntry] = [ChartDataEntry]()
    
    // lineChartDataEntry converted to LineChartDataSet
    public private(set) var line1: LineChartDataSet?
    
    // FINAL Object that will be added to the chart. Changing its value causes chart to be updated.
    public private(set) var dataLine1: LineChartData = LineChartData()
    
    // X Axis legend values that will be shown above the chart.
    public private(set) var xValues: [String] = []
    
    public private(set) var xAxis: XAxis = XAxis()
    
    init(dataSet: [Double], xValues: [String]) {
        self.numbers = dataSet
        self.xValues = xValues
        self.setupChart()
    }
    
    private func setupChart() {
        let count = numbers?.count ?? 0
        for i in 0 ..< count {
            // Setting x and y points in chart
            let value = ChartDataEntry(x: Double(i), y: numbers![i])
            lineChartDataEntry.append(value)
        }
        self.line1 = LineChartDataSet(values: lineChartDataEntry, label: nil)
        self.dataLine1.addDataSet(line1)
        
        let chartFormatter = BarChartFormatter(labels: xValues)
        self.xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
    }
    
}
