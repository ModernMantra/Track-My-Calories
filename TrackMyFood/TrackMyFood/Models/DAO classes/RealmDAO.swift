//
//  RealmDAO.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/27/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDAO<T: Object> {
    
    func getAllData() -> Results<T>? {
        guard let realm = try? Realm() else {
            return nil
        }
        return realm.objects(T.self)
    }
    
    func itemsCount() -> Int {
        guard let realm = try? Realm() else {
            return -1
        }
        return realm.objects(T.self).count
    }
    
    func hasAnyData() -> Bool {
        guard let realm = try? Realm() else {
            return false
        }
        return realm.objects(T.self).count > 0
    }
    
    func insert(data: T, update: Bool = false) {
        guard let realm = try? Realm() else {
            return
        }
        try? realm.write {
            realm.add(data, update: update)
        }
    }
    
    func delete(data: T) {
        guard let realm = try? Realm() else {
            return
        }
        try? realm.write {
            realm.delete(data)
        }
    }
    
}
