//
//  QuoteCellModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/3/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

class QuoteCellModel {
    
    public private(set) var message: String
    public var messageFormatted: String {
        get { return self.message.uppercased() }
    }
    
    init(message: String) {
        self.message = message
    }
}
