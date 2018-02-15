//
//  UINavigationItemExtension.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/10/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    
    func addBarCustomButtonItem(side: BarButtonSide, image: UIImage, frame: CGRect, action: Selector) {
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(image, for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = frame
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        if (side == .left) {
            self.leftBarButtonItem = barButton
        }
        else {
            self.rightBarButtonItem = barButton
        }
    }
    
}
