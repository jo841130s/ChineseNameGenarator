//
//  TraitsCell.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/23.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class TraitsCell: UITableViewCell {

    @IBOutlet var brushImageView: UIImageView!
    @IBOutlet var traitLabel: UILabel!
    let isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if isForeigner {
            traitLabel.font = UIFont(name: "Centaur", size: 24)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
