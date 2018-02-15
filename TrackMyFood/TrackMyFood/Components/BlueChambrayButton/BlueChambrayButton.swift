//
//  BlueWhaleButton.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/24/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

public enum BlueChambrayButtonState {
    case selected
    case deselected
}

@IBDesignable
open class BlueChambrayButton: UIButton {
    
    public var buttonState: BlueChambrayButtonState {
        get {
            return self.buttonState
        }
        set {
            if (newValue == .selected) {
                self.isSelected = true
                self.backgroundColor = self.selectedBackgroundColor
                self.setTitleColor(selectedTextColor, for: .highlighted)
            }
            else {
                self.isSelected = false
                self.backgroundColor = deselectedBackgroundColor
                self.setTitleColor(deselectedTextColor, for: .normal)
            }
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 7.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var selectedBackgroundColor: UIColor = UIColor.Blue.Chambray {
        didSet {
            if (self.isSelected) {
                self.backgroundColor = selectedBackgroundColor
            }
        }
    }
    
    @IBInspectable public var selectedTextColor: UIColor = UIColor.white {
        didSet {
            if (self.isSelected) {
                self.setTitleColor(selectedTextColor, for: .highlighted)
            }
        }
    }
    
    @IBInspectable public var deselectedBackgroundColor: UIColor = UIColor.Blue.Chambray {
        didSet {
            if (!self.isSelected) {
                self.backgroundColor = deselectedBackgroundColor
            }
        }
    }
    
    @IBInspectable public var deselectedTextColor: UIColor = UIColor.white {
        didSet {
            if (!self.isSelected) {
                self.setTitleColor(deselectedTextColor, for: .normal)
            }
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }
    
    private func initView() {
        self.backgroundColor = UIColor.Blue.Chambray
        self.layer.cornerRadius = self.cornerRadius
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        if (self.isSelected) {
            self.setTitleColor(self.selectedTextColor, for: .normal)
        }
        else {
            self.setTitleColor(self.deselectedTextColor, for: .normal)
        }
    }

}
