//
//  RoundedSegmentedControl.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 11/27/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundedSegmentedControl: UISegmentedControl {
    
    private var one_one: CGSize {
        get {
            return CGSize(width: 1, height: 1)
        }
    }
    
    @IBInspectable var selectedLabelColor : UIColor = UIColor.white {
        didSet {
            self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : self.selectedLabelColor], for: .selected)
        }
    }
    
    @IBInspectable var unselectedLabelColor : UIColor = UIColor.white {
        didSet {
            self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : self.unselectedLabelColor], for: .normal)
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.white {
        didSet {
            self.tintColor = self.borderColor
        }
    }
    
    @IBInspectable var dividerColor: UIColor = UIColor.white {
        didSet {
            if let tintImage = UIImage.imageWithSize(size: self.one_one, color: dividerColor){
                setDividerImage(tintImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupView()
    }
    
    func setupView(){
        for i in 0..<self.numberOfSegments {
            let title = self.titleForSegment(at: i) ?? ""
            self.setTitle(title.capitalized, forSegmentAt: i)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
