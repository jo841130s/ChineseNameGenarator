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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func genderSegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            genderImageView.image = UIImage(named: "male")
        } else {
            genderImageView.image = UIImage(named: "female")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
