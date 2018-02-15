//
//  SegmentsTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 11/27/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

protocol SegmentsTableViewCellDelegate: class {
    func segmentedValueChanged(index: Int)
}
class SegmentsTableViewCell: UITableViewCell {

    @IBOutlet weak var segmentControl: RoundedSegmentedControl!
    
    private var model: SegmentsCellModel?
    weak var delegate: SegmentsTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.segmentControl.addTarget(self, action: #selector(self.segmentValueChanged(sender:)), for: .valueChanged)
        // Initialization code
    }
    
    func initCell(model: SegmentsCellModel, delegate: SegmentsTableViewCellDelegate?) {
        self.delegate = delegate
        self.model = model
        self.setupSegmentedControl()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @objc func segmentValueChanged(sender: AnyObject?){
        let index = self.segmentControl.selectedSegmentIndex
        self.delegate?.segmentedValueChanged(index: index)
    }
    
    private func setupSegmentedControl() {
        for i in 0..<self.segmentControl.numberOfSegments {
            let title = self.model?.segmentedControlTitles[i]
            self.segmentControl.setTitle(title?.uppercased(), forSegmentAt: i)
        }
    }
    
}
