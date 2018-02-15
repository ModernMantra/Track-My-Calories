//
//  DateExtension.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 11/18/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var components: DateComponents {
        get {
            let units: NSCalendar.Unit = [NSCalendar.Unit.day,
                                          NSCalendar.Unit.era,
                                          NSCalendar.Unit.minute,
                                          NSCalendar.Unit.month,
                                          NSCalendar.Unit.hour,
                                          NSCalendar.Unit.weekday,
                                          NSCalendar.Unit.weekOfYear,
                                          NSCalendar.Unit.weekOfMonth,
                                          NSCalendar.Unit.year]
            let calendar = Calendar.current
            let components = (calendar as NSCalendar).components(units, from: self)
            return components
        }
    }
    
    var monthString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM"
            return dateFormatter.string(from: self)
        }
    }

}
