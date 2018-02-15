//
//  PhotoRecognitionStateModel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/26/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class PhotoRecognitionStateModel {
    
    var recognizedFoodName: String?
    var foodImage: UIImage?
    
    static let sharedInstance: PhotoRecognitionStateModel = PhotoRecognitionStateModel()
    
    private init() {
        
    }
    
}
