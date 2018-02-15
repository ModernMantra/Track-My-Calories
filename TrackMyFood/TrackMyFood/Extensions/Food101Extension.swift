//
//  Food101Extension.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/25/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit
import CoreML

extension Food101 {
    
    static let imageSize = CGSize(width: 299, height: 299)

    
    func preprocess(image: UIImage) -> MLMultiArray? {
        guard let pixels = image.resize(to: Food101.imageSize).pixelData()?.map({ (Double($0) / 255.0 - 0.5) * 2 }) else {
            return nil
        }
        
        guard let array = try? MLMultiArray(shape: [3, 299, 299], dataType: .double) else {
            return nil
        }
        
        let r = pixels.enumerated().filter { $0.offset % 4 == 0 }.map { $0.element }
        let g = pixels.enumerated().filter { $0.offset % 4 == 1 }.map { $0.element }
        let b = pixels.enumerated().filter { $0.offset % 4 == 2 }.map { $0.element }
        
        let combination = r + g + b
        for (index, element) in combination.enumerated() {
            array[index] = NSNumber(value: element)
        }
        
        return array
    }
    
}
