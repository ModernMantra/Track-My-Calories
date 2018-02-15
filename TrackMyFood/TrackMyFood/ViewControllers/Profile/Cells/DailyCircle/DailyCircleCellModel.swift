//
//  DailyCircleCellModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 2/10/18.
//  Copyright © 2018 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

class DailyCircleCellModel {
    
    var isAnimated: Bool = false
    public private(set) var totalConsumption: Int?
    public private(set) var currentConsumption: Int?
    public var circleProgressValue: CGFloat {
        get {
            return 1230
        }
    }
    
    init(totalConsumption: Int, currentConsumption: Int) {
        self.totalConsumption = totalConsumption
        self.currentConsumption = currentConsumption
    }
    
}
