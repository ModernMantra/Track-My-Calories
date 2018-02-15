//
//  SaveFoodTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/30/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

protocol SaveButtonCellDelegate: class {
    func buttonTapped()
}
class SaveFoodTableViewCell: UITableViewCell {

    @IBOutlet weak var button: BlueChambrayButton!
    weak var delegate: SaveButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Action
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.delegate?.buttonTapped()
    }
    
}
