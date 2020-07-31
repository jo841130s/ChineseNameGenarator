//
//  HomeViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/7.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import MessageUI

class HomeViewController: UIViewController {
    
    @IBOutlet weak var middleImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet var contachUsButton: UIButton!
    @IBOutlet weak var coinLabel: UILabel!
    let userData = UserData()
    var apiBuilder = APIBuilder()
    var timer = Timer()
    var degree = 0.0
    var iapManager = IAPManager.shared
    var remainTimes = {
        return IAPManager.canUsedTimes + IAPManager.buyTimes() - IAPManager.usedTimes()
    }
    var paymentData : [[String:String]] = []
    
    override func viewWillAppear(_ animated: Bool) {
        apiBuilder.requestUsedCount()
        iapManager.getProducts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiBuilder.delegate = self
        iapManager.delegate = self
        let buttons : [UIButton] = [startButton, historyButton, tipsButton, contachUsButton]
        for button in buttons {
            button.addCorner(radious: 5)
        }
        if startButton.titleLabel?.text == "Start" {
            UserData.setUserData(data: true, name: "isForeigner")
            UserData.isForeigner = true
        } else {
            UserData.setUserData(data: false, name: "isForeigner")
            UserData.isForeigner = false
        }
    }

    @IBAction func buyTimesButtonPressed(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BuyViewController") as? BuyViewController {
            vc.modalPresentationStyle = .overFullScreen
            vc.paymentData = paymentData
            present(vc, animated: false, completion: nil)
        }
        
        
//        iapManager.buy(product: iapManager.products[0])
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        if remainTimes() <= 0 {
            reachUsedLimitAlert()
        } else if remainTimes() <= 3 && remainTimes() > 0{
            timeRemainsAlert(remainTimes: remainTimes())
        } else {
            performSegue(withIdentifier: "startNaming", sender: self)
        }
    }
    
    @IBAction func contactUsButtonPressed(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["chinesenaming_app@sayhi.tw"])
            present(mail, animated: true)
        } else {
            var title = ""
            var message = ""
            switch UserData.isForeigner {
            case true:
                title = "Contact Us"
                message = "You can contact us with this email, chinesenaming_app@sayhi.tw"
            case false:
                title = "聯絡我們"
                message = "你可以用這個 email 跟我們聯絡，chinesenaming_app@sayhi.tw"
            }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func reachUsedLimitAlert() {
        let alert = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let buyAction = UIAlertAction(title: "Buy", style: .default) { (action) in
            self.iapManager.buy(product: self.iapManager.products[0])
        }
        alert.addAction(okAction)
        alert.addAction(buyAction)
        present(alert, animated: true, completion: nil)
    }
    
    func timeRemainsAlert(remainTimes:Int) {
        var alert = UIAlertController()
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "startNaming", sender: self)
        })
        var cancelAction = UIAlertAction()
        
        switch UserData.isForeigner {
        case true:
            cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert = UIAlertController(title: "Attention!", message: "Available number of times: \(remainTimes)", preferredStyle: .alert)
        case false:
            cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert = UIAlertController(title: "注意!", message: "剩餘次數: \(remainTimes)", preferredStyle: .alert)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension HomeViewController : APIDelegate {
    func nameDataReceived(data: NameData) {
        print("")
    }
    
    func nameDataNotReceived(error: AFError?) {
        print("")
    }
    
    func usedCountReceived(count: Int) {
        UserDefaults.standard.set(count, forKey: "UsedTimes")
        updateCoinLabel()
    }
    
    func usedCountNotReceived(error: AFError?) {
        var title = ""
        var message = ""
        switch UserData.isForeigner {
        case true:
            title = "Connent Failed"
            message = "Open wifi"
        case false:
            title = "網路連線失敗"
            message = "請開啟網路"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func updateCoinLabel() {
        
        if remainTimes() < 0 {
            UserDefaults.standard.set("0", forKey: "RemainTimes")
            coinLabel.text = UserDefaults.standard.string(forKey: "RemainTimes")
        } else {
            UserDefaults.standard.set("\(remainTimes())", forKey: "RemainTimes")
            coinLabel.text = UserDefaults.standard.string(forKey: "RemainTimes")
        }
    }
    
}

extension HomeViewController : IAPManagerDelegate {
    
    func finishPurchase() {
        coinLabel.text = "\(remainTimes())"
    }
    
    func getPaymentInfo(info: [String : String]) {
        paymentData.append(info)
    }
    
}

extension HomeViewController : MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}

extension UIButton {
    
    func addCorner(radious:CGFloat) {
        self.layer.cornerRadius = radious
    }
}
