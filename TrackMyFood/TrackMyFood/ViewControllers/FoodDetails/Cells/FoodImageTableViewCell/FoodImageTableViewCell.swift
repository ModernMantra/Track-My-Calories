//
//  FoodImageTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/27/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class FoodImageTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(image: UIImage) {
        self.foodImageView.image = image
    }
    
}
