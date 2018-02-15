//
//  ProgressBarTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/5/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import UICountingLabel

class ProgressBarTableViewCell: UITableViewCell {
    
    @IBOutlet public weak var leftProgressBar: MBCircularProgressBarView!
    @IBOutlet public weak var middleProgressbar: MBCircularProgressBarView!
    @IBOutlet public weak var rightProgressBar: MBCircularProgressBarView!
    
    @IBOutlet weak var fatLabel: UICountingLabel!
    @IBOutlet weak var carbLabel: UICountingLabel!
    @IBOutlet weak var proteinLabel: UICountingLabel!
    
    private var cellModel: ProgressBarCellModel?
    private var isAnimated: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func initCell(_ model: ProgressBarCellModel) {
        self.cellModel = model
        self.resetBars()
    }
    
    private func resetBars() {
        self.isAnimated = false
        self.leftProgressBar.value = 0
        self.middleProgressbar.value = 0
        self.rightProgressBar.value = 0
    }
    
    // CALL THE FUNCTION ONLY WHEN CELL IS VISIBLE, OTHERWISE ANIMTION WILL NOT BE SHOWN
    func animateProgressBars() {
        if (!isAnimated) {
            self.isAnimated = true
            self.animateLabels()
            self.animateProgressCircles()
        }
    }
    
    private func animateLabels() {
        let duration = 1.2
        
        self.carbLabel.countFromZero(to: (self.cellModel?.carbLabelValue)!, withDuration: duration)
        self.carbLabel.method = .easeOut
        self.carbLabel.format = "%dg"
        
        self.proteinLabel.countFromZero(to: (self.cellModel?.proteinLabelValue)!, withDuration: duration)
        self.proteinLabel.method = .easeOut
        self.proteinLabel.format = "%dg"
        
        self.fatLabel.countFromZero(to: (self.cellModel?.fatLabelValue)!, withDuration: duration)
        self.fatLabel.method = .easeOut
        self.fatLabel.format = "%dg"
    }
    
    private func animateProgressCircles() {
        UIView.animate(withDuration: 1.2, animations: {
            self.leftProgressBar.value = 35
        })
        UIView.animate(withDuration: 1.2, animations: {
            self.middleProgressbar.value = 75
        })
        UIView.animate(withDuration: 1.2, animations: {
            self.rightProgressBar.value = 80
        })
    }
    
}
