//
//  HomeViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/7.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var middleImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tipsButton: UIButton!
    var timer = Timer()
    var degree = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinMiddleImage()
        setButton(button: startButton)
        setButton(button: historyButton)
        setButton(button: tipsButton)
    }
    
    func spinMiddleImage(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(spinAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func spinAnimation() {
        degree += 0.005
        middleImage.transform = CGAffineTransform(rotationAngle: CGFloat(degree))
    }
    
    func setButton(button:UIButton) {
        button.layer.cornerRadius = 5
    }

}
