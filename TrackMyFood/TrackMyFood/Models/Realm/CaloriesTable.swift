//
//  DBFood.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/27/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import RealmSwift

class CaloriesTable: Object {
    @objc dynamic var food: String?
    @objc dynamic var measure: String?
    var weight: Double?
    var kCal: Int?
    var fat: Int?
    var carbo: Int?
    var protein: Int?
}
