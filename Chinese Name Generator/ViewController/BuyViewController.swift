//
//  BuyViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/7/31.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var price3: UILabel!
    @IBOutlet weak var number3: UILabel!
    
    var paymentData : [[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
        backgroundView.layer.cornerRadius = 10
        closeButton.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    func updateLabel() {
        for data in paymentData {
            switch data["title"] {
            case "Five Naming Chances":
                price1.text = data["price"]
                number1.text = "5"
            case "Twelve Naming Chances":
                price2.text = data["price"]
                number2.text = "12"
            case "Twenty Naming Chances":
                price3.text = data["price"]
                number3.text = "20"
            default:
                break
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
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
