//
//  DailyCircleTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 2/10/18.
//  Copyright © 2018 Kerim Njuhovic. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import UICountingLabel

class DailyCircleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circleProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var mainValue: UICountingLabel!
    @IBOutlet weak var outOfTotalLabel: UILabel!
    
    private var model: DailyCircleCellModel?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initCell(model: DailyCircleCellModel) {
        self.model = model
        self.resetBar()
    }
    
    func resetBar() {
        self.circleProgressBar.value = 0
        self.model?.isAnimated = false
    }
    
    // CALL THE FUNCTION ONLY WHEN CELL IS VISIBLE, OTHERWISE ANIMTION WILL NOT BE SHOWN
    func animateCircleProgressBar() {
        if (!(self.model?.isAnimated)!) {
            self.model?.isAnimated = true
            let duration = 1.5
            self.mainValue.countFromZero(to: (self.model?.circleProgressValue)!, withDuration: duration)
            self.mainValue.method = .easeOut
            self.mainValue.format = "%d"
            UIView.animate(withDuration: duration, animations: {
                self.circleProgressBar.value = 80
            })
        }
    }
    
}
