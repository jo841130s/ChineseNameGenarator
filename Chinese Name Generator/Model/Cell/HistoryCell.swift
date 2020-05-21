//
//  HistoryCell.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/5/19.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var chineseNameLabel: UILabel!
    @IBOutlet var frontImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
