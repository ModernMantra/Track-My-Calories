//
//  TwoStateLabel.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/16/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

public enum LabelState {
    case selected
    case deselected
}

open class TwoStateLabel: UILabel {
    
    public var bottomBorder: CALayer?
    
    public var state: LabelState? {
        get {
            return self.state
        }
        set {
            if (newValue == LabelState.selected) {
                self.bottomBorder?.backgroundColor = UIColor.Blue.Chambray.cgColor
            }
            else {
                self.bottomBorder?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            }
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)!
        setupView()
    }
    
    func setupView() {
        self.state = LabelState.deselected
        self.addBottomLine(height: 2.0, color: UIColor.lightGray.withAlphaComponent(0.5))
    }
    
    func addBottomLine(height: CGFloat, color: UIColor) {
        bottomBorder = CALayer()
        bottomBorder?.frame = CGRect(x: 0,
                                    y: self.frame.size.height + (3 * height),
                                    width: self.frame.size.width,
                                    height: height)
        bottomBorder?.backgroundColor = color.cgColor
        self.layer.addSublayer(bottomBorder!)
    }
    
}
