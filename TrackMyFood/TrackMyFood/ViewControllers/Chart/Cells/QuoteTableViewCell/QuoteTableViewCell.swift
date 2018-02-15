//
//  QuoteTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/3/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    var cellModel: QuoteCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(_ model: QuoteCellModel) {
        self.cellModel = model
        self.messageLabel.text = self.cellModel?.messageFormatted
    }
    
}
