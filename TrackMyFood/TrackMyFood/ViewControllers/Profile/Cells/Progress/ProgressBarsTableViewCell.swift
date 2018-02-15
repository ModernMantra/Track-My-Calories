//
//  ProgressBarsTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 2/10/18.
//  Copyright © 2018 Kerim Njuhovic. All rights reserved.
//

import UIKit

class ProgressBarsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weightLabelLeft: UILabel!
    @IBOutlet weak var weightLabelRight: UILabel!
    @IBOutlet weak var descriptionLabelLeft: UILabel!
    @IBOutlet weak var descriptionLabelRight: UILabel!
    @IBOutlet weak var progressBarLeft: UIProgressView!
    @IBOutlet weak var progressBarRight: UIProgressView!
    
    private var cellModel: ProgressBarsCellModel?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initCell(cellModel: ProgressBarsCellModel) {
        self.cellModel = cellModel
    }
    
    private func setupView() {
        self.weightLabelLeft.text = self.cellModel?.weightL
        self.weightLabelRight.text = self.cellModel?.weightR
        
        self.descriptionLabelLeft.text = self.cellModel?.descriptionL
        self.descriptionLabelRight.text = self.cellModel?.descriptionR
        
        self.progressBarLeft.progress = (self.cellModel?.progressValueL)!
        self.progressBarRight.progress = (self.cellModel?.progressValueR)!
    }
    
    
}
