//
//  FoodItemHeaderTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 11/18/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class FoodItemHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
    private var viewModel: HeaderItemCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(_ model: HeaderItemCellModel) {
        self.viewModel = model
        self.dateLabel.text = self.viewModel?.dateFormatted
    }
    
}
