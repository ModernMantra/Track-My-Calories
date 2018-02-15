//
//  ProgressBarsCellModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 2/10/18.
//  Copyright © 2018 Kerim Njuhovic. All rights reserved.
//

import Foundation

class ProgressBarsCellModel {
    
    public private(set) var weightL: String?
    public private(set) var weightR: String?
    public private(set) var descriptionL: String?
    public private(set) var descriptionR: String?
    public private(set) var progressValueL: Float?
    public private(set) var progressValueR: Float?
    
    init(weightL: String, weightR: String, descriptionL: String, descriptionR: String, progressL: Float, progressR: Float) {
        self.weightL = weightL
        self.weightR = weightR
        self.descriptionL = descriptionL
        self.descriptionR = descriptionR
        self.progressValueL = progressL
        self.progressValueR = progressR
    }
    
}
