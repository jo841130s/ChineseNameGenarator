//
//  GenderViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/23.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class GenderViewController: UIViewController {

    @IBOutlet var genderSegmentControl: UISegmentedControl!
    @IBOutlet var genderImageView: UIImageView!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.addCorner(radious: 5)
        if let font = UIFont(name: "jf-openhuninn-1.1", size: 12) {
            genderSegmentControl.setTitleTextAttributes([.font: font ], for: .normal)
        }
    }
    

    @IBAction func genderSegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            genderImageView.image = UIImage(named: "male")
        } else {
            genderImageView.image = UIImage(named: "female")
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        var gender = "Male"
        if genderSegmentControl.selectedSegmentIndex == 0 {
            gender = "Male"
        } else if genderSegmentControl.selectedSegmentIndex == 1 {
            gender = "Female"
        }
        UserData().setUserData(data: gender, name: "Gender")
    }

}
