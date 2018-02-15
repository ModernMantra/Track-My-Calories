//
//  CalendarExtension.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 11/25/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

extension Calendar {
    
    func getDateSuffix(from date: Date) -> String {
        var suffix: String
        switch (self.component(.day, from: date)) {
        case 1:
            suffix = "st"
        case 2:
            suffix = "nd"
        case 3:
            suffix = "rd"
        case 21:
            suffix = "st"
        case 22:
            suffix = "nd"
        case 23:
            suffix = "rd"
        case 31:
            suffix = "st"
        default:
            suffix = "th"
        }
        return suffix
    }
    
    func getWeekdayString(from date: Date) -> String {
        let weekDay = self.component(.weekday, from: date)
        let weekdays = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"
        ]
        return weekdays[weekDay - 1]
    }
    
}
