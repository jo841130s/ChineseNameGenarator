//
//  NameInformationCell.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/2.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class NameInformationCell: UITableViewCell {
    
    @IBOutlet var charLabel: UILabel!
    @IBOutlet var englishSoundLabel: UILabel!
    @IBOutlet var strokeLabel: UILabel!
    @IBOutlet var meaningLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
