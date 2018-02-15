//
//  ProgressBarCellModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/5/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

class ProgressBarCellModel {
    
    public private(set) var proteinConsumption: [Double] = []
    public private(set) var carbConsumption: [Double] = []
    public private(set) var fatConsumption: [Double] = []
    
    public private(set) var proteinLabelValue: CGFloat = 0
    public private(set) var fatLabelValue: CGFloat = 0
    public private(set) var carbLabelValue: CGFloat = 0
    
    // BAr progress computed properties
    
    init(proteinConsumption: [Double], carbConsumption: [Double], fatConsumption: [Double]) {
        self.proteinConsumption = proteinConsumption
        self.carbConsumption = carbConsumption
        self.fatConsumption = fatConsumption
    }
    
}
