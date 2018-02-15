//
//  NutritionTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/29/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class NutritionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kCalLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    
    private var viewModel: NutritionCellModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initCell(_ model: NutritionCellModel) {
        self.viewModel = model
        self.setupCell()
    }
    
    private func setupCell() {
        self.kCalLabel.text = self.viewModel?.kCal
        self.proteinLabel.text = self.viewModel?.protein
        self.carbLabel.text = self.viewModel?.carbo
        self.fatLabel.text = self.viewModel?.fat
    }
    
}
