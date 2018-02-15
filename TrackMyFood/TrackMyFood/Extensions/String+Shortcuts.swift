//
//  String+Shortcuts.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/24/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

extension String {
    
    var lenght: Int {
        get { return self.count }
    }
    
    var integerOnly: Int? {
        get {
            return Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
        }
    }
    
    func stringWithLineHeight(_ height: CGFloat, textAlignment: NSTextAlignment = .center) -> NSMutableAttributedString {
        let paragraphsStyle = NSMutableParagraphStyle()
        paragraphsStyle.lineSpacing = height
        paragraphsStyle.alignment = textAlignment
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle,
                                      value: paragraphsStyle,
                                      range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
}
