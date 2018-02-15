//
//  HeaderItemCellModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 11/25/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

class HeaderItemCellModel {
    
    public private(set) var date: Date?
    
    var dateFormatted: String {
        get {
            let calendar = Calendar.current
            let date = self.date ?? Date()
            let weekday = calendar.getWeekdayString(from: date)
            let suffix = calendar.getDateSuffix(from: date)
            let month = date.monthString
            let day = date.components.day ?? 1
            let year = date.components.year ?? 1
            
            return "\(weekday), \(month) \(day)\(suffix) \(year)".capitalized
        }
    }
    
    init(date: Date) {
        self.date = date
    }
    
    
    
}
