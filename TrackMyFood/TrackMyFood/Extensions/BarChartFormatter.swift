//
//  BarChartView.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/2/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit
import Charts

@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter {
        
    var labels: [String] = []
        
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let label = labels[safe: Int(value)] else {
            return ""
        }
        return label
    }
        
    init(labels: [String]) {
        super.init()
        self.labels = labels
    }
    
}
