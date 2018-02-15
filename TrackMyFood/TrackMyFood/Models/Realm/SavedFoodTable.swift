//
//  SavedFoodTable.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 10/13/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import RealmSwift

class SavedFoodTable: Object {
    @objc dynamic var date: Date?
    @objc dynamic var foodName: String?
}
