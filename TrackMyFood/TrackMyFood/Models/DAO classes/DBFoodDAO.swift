//
//  DBFoodDAO.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/27/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import RealmSwift

class DBFoodDAO: RealmDAO<CaloriesTable> {
    
    func getAllData(_ realm: Realm) -> Results<CaloriesTable>? {
        return realm.objects(CaloriesTable.self)
    }
    
    func getData(_ realm: Realm, foodName: String) -> CaloriesTable? {
        return realm.objects(CaloriesTable.self).filter("foodName == @%", foodName).first
    }
    
    func itemsCount(_ realm: Realm) -> Int {
        return realm.objects(CaloriesTable.self).count
    }
    
    func hasAnyData(_ realm: Realm) -> Bool {
        return realm.objects(CaloriesTable.self).count > 0
    }
    
}
