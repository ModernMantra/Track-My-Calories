//
//  DictionaryExtension.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/26/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

extension Dictionary where Value:Comparable {
    var sortedByValue:[(Key,Value)] {
        return Array(self).sorted{$0.1 < $1.1}
    }
}
extension Dictionary where Key:Comparable {
    var sortedByKey:[(Key,Value)] {
        return Array(self).sorted{$0.0 < $1.0}
    }
}
