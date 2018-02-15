//
//  DBSavedRecognisedFoodDAO.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 10/13/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import RealmSwift

class DBSavedRecognisedFoodDAO: RealmDAO<SavedFoodTable> {
    
    func getFood(date: Date) -> Results<SavedFoodTable>? {
        guard let realm = try? Realm() else {
            return nil
        }
        let objects =  realm.objects(SavedFoodTable.self)
        var results: [SavedFoodTable] = []
        for object in objects {
            let order = NSCalendar.current.compare(date, to: object.date!, toGranularity: .day)
            if (order == .orderedSame) {
                results.append(object)
            }
        }
        return objects
    }
    
}
