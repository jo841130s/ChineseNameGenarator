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

class HomeViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var middleImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet var contachUsButton: UIButton!
    let userData = UserData()
    var isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")
    var apiBuilder = APIBuilder()
    var timer = Timer()
    var degree = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiBuilder.delegate = self
        setButton(button: startButton)
        setButton(button: historyButton)
        setButton(button: tipsButton)
        setButton(button: contachUsButton)
        if startButton.titleLabel?.text == "Start" {
            userData.setUserData(data: true, name: "isForeigner")
            isForeigner = true
        } else {
            userData.setUserData(data: false, name: "isForeigner")
            isForeigner = false
        }
    }
    
    func setButton(button:UIButton) {
        button.addCorner(radious: 5)
    }

    @IBAction func startButtonPressed(_ sender: Any) {
        apiBuilder.requestUsedCount()
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
            switch isForeigner {
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
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
        if count < 12 {
            var alert = UIAlertController()
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "startNaming", sender: self)
            })
            var cancelAction = UIAlertAction()
            
            switch isForeigner {
            case true:
                cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert = UIAlertController(title: "Attention!", message: "Available number of times: \(12-count)", preferredStyle: .alert)
            case false:
                cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alert = UIAlertController(title: "注意!", message: "剩餘次數: \(12-count)", preferredStyle: .alert)
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        } else {
            switch isForeigner {
            case true:
                reachUsedLimitAlert(title: "Reach usage limit!", message: "")
            case false:
                reachUsedLimitAlert(title: "使用次數達到上限", message: "")
            }
        }
    }
    
    func usedCountNotReceived(error: AFError?) {
        var title = ""
        var message = ""
        switch isForeigner {
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
    
    func reachUsedLimitAlert(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension UIButton {
    
    func addCorner(radious:CGFloat) {
        self.layer.cornerRadius = radious
    }
}
