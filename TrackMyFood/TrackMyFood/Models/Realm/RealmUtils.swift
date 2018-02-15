//
//  RealmUtils.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/27/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUtils {
    
    static let sharedInstance = RealmUtils()

    var bundledRealm: Realm? {
        get {
            let path = Bundle.main.url(forResource: "default", withExtension: "realm")
            let config = Realm.Configuration(
                // Get the path to the bundled file
                fileURL: path,
                // Open the file in read-only mode as application bundles are not writeable
                readOnly: true)
            
            // Open the Realm with the configuration
            let realm = try? Realm(configuration: config)
            
            return realm
        }
    }
    
    private init() {
        
    }
    
}
