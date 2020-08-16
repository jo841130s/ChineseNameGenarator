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

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var middleImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet var contachUsButton: UIButton!
    @IBOutlet weak var coinLabel: UILabel!
    var apiBuilder = APIBuilder()
    var iapManager = IAPManager.shared
    var remainTimes = {
        return IAPManager.canUsedTimes + IAPManager.buyTimes() - IAPManager.usedTimes()
    }
    var paymentData : [[String:String]] = []
    
    override func viewWillAppear(_ animated: Bool) {
        if startButton.titleLabel?.text == "Start" {
            UserData.setUserData(data: true, name: "isForeigner")
            UserData.isForeigner = true
        } else {
            UserData.setUserData(data: false, name: "isForeigner")
            UserData.isForeigner = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        apiBuilder.delegate = self
        apiBuilder.requestUsedCount()
        iapManager.delegate = self
        iapManager.getProducts()
        let buttons : [UIButton] = [startButton, historyButton, tipsButton, contachUsButton]
        for button in buttons {
            button.addCorner(radious: 5)
        }
    }

    @IBAction func buyTimesButtonPressed(_ sender: UIButton) {
        if paymentData.count != 0 {
            goPurchase()
        } else {
            return
        }
    }
    
    func goPurchase() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BuyViewController") as? BuyViewController {
            vc.modalPresentationStyle = .overFullScreen
            vc.paymentData = paymentData
            present(vc, animated: false, completion: nil)
        } else {
            print("12345678")
        }
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
    
    @IBAction func historyButtonPressed(_ sender: UIButton) {
        if IAPManager.buyTimes() > 0 {
            performSegue(withIdentifier: "goHistory", sender: self)
        } else {
            unpurchasedAlert()
        }
    }
    
    func unpurchasedAlert() {
        var alert = UIAlertController()
        var okAction = UIAlertAction()
        var puchaseAction = UIAlertAction()
        if UserData.isForeigner {
            alert = UIAlertController(title: "Oops!", message: "You must purchase to get this function", preferredStyle: .alert)
            okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            puchaseAction = UIAlertAction(title: "Purchase", style: .default, handler: { (action) in
                self.goPurchase()
            })
        } else {
            alert = UIAlertController(title: "Oops!", message: "須先購買才能得到此功能", preferredStyle: .alert)
            okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            puchaseAction = UIAlertAction(title: "購買", style: .default, handler: { (action) in
                self.goPurchase()
            })
        }
        alert.addAction(okAction)
        alert.addAction(puchaseAction)
        present(alert, animated: true, completion: nil)
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
        let alert = UIAlertController(title: "命名次數已使用完畢!", message: "請購買已取得更多次數", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let purchaseAction = UIAlertAction(title: "購買", style: .default) { (action) in
            self.goPurchase()
        }
        alert.addAction(okAction)
        alert.addAction(purchaseAction)
        present(alert, animated: true, completion: nil)
    }
    
    func timeRemainsAlert(remainTimes:Int) {
        var alert = UIAlertController()
        var startAction = UIAlertAction()
        var purchaseAction = UIAlertAction()
        var cancelAction = UIAlertAction()
        
        switch UserData.isForeigner {
        case true:
            startAction = UIAlertAction(title: "Start Naming", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "startNaming", sender: self)
            })
            cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            purchaseAction = UIAlertAction(title: "Buy", style: .default, handler: { (action) in
                self.goPurchase()
            })
            alert = UIAlertController(title: "Attention!", message: "Available number of times for naming: \(remainTimes)", preferredStyle: .alert)
        case false:
            startAction = UIAlertAction(title: "開始取名", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "startNaming", sender: self)
            })
            cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            purchaseAction = UIAlertAction(title: "購買", style: .default, handler: { (action) in
                self.goPurchase()
            })
            alert = UIAlertController(title: "注意!", message: "剩餘次數: \(remainTimes)", preferredStyle: .alert)
        }
        alert.addAction(startAction)
        alert.addAction(purchaseAction)
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
        if UserData.isForeigner {
            coinLabel.text = "Remaining:\(remainTimes())"
        } else {
            coinLabel.text = "剩餘次數:\(remainTimes())"
        }
    }
    
}

extension HomeViewController : IAPManagerDelegate {
    
    func finishPurchase() {
        updateCoinLabel()
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
