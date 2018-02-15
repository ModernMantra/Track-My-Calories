//
//  HashTagsTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/28/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class HashTagsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    
    private var labels: [UILabel]?
    private var viewModel: HashTagsCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labels = [labelOne, labelTwo, labelThree, labelFour, labelFive]
        if let labels = self.labels {
            for label in labels {
                label.layer.cornerRadius = label.frame.size.height / 5
                label.clipsToBounds = true
            }
        }
    }
    
    func initCell(_ model: HashTagsCellModel) {
        self.viewModel = model
        self.setupCell()
    }
    
    private func setupCell() {
        if let labels = self.labels {
            if (labels.count == self.viewModel?.hashTags.count) {
                for (label, string) in zip(labels, (self.viewModel?.hashTags)!) {
                    label.text = string
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
