//
//  FoodItemTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 10/13/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var infoTextLabel: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var info: UILabel!
    
    private var viewModel: FoodItemCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        // Initialization code
    }
    
    private func setupView() {
        self.containerView.layer.cornerRadius = 8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setUpCell(_ model: Food) {
        self.viewModel?.foodName = model.foodName
        self.viewModel?.kCal = model.kCal
        self.foodName.text = self.viewModel?.foodName
        self.infoTextLabel.text = self.viewModel?.infoText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
