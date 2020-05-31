//
//  HistoryCell.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/5/19.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import AVFoundation

class HistoryCell: UITableViewCell {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var chineseNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func soundButtonPressed(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: chineseNameLabel.text ?? "")
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        utterance.rate = 0.1
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
