//
//  ArrayExtension.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/3/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

extension Array {
    
    
    /// Prevenmts getting index out of range. Will return nil in case index is out of range
    ///
    /// - Parameter index: index of element to be accessed within array
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
