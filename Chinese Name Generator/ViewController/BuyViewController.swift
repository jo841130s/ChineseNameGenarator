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
    @IBOutlet weak var price1: UIButton!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var price2: UIButton!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var price3: UIButton!
    @IBOutlet weak var number3: UILabel!
    @IBOutlet weak var timesLabel1: UILabel!
    @IBOutlet weak var timesLabel2: UILabel!
    @IBOutlet weak var timesLabel3: UILabel!
    @IBOutlet weak var purchaseTitle: UILabel!
    
    var paymentData : [[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
        backgroundView.layer.cornerRadius = 10
        closeButton.layer.cornerRadius = 20
    }
    
    func updateLabel() {
        if UserData.isForeigner {
            purchaseTitle.text = "Select One Package and Purchase."
            timesLabel1.text = "Times"
            timesLabel2.text = "Times"
            timesLabel3.text = "Times"
        } else {
            purchaseTitle.text = "請選擇一個方案購買"
            timesLabel1.text = "次"
            timesLabel2.text = "次"
            timesLabel3.text = "次"
        }
        price1.addCorner(radious: 5)
        price2.addCorner(radious: 5)
        price3.addCorner(radious: 5)
        for data in paymentData {
            switch data["title"] {
            case "Small Package(5 times)", "五次取名次數":
                let price = data["price"] ?? ""
                price1.setTitle("\(price)", for: .normal)
                number1.text = "5"
            case "Medium Package(12 times)", "十二次取名次數":
                let price = data["price"] ?? ""
                price2.setTitle("\(price)", for: .normal)
                number2.text = "12"
            case "Big Package(20 times)", "二十次取名次數":
                let price = data["price"] ?? ""
                price3.setTitle("\(price)", for: .normal)
                number3.text = "20"
            default:
                break
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func purchaseButtonPressed(_ sender: UIButton) {
        IAPManager.buy(product: IAPManager.products[sender.tag])
    }

}
