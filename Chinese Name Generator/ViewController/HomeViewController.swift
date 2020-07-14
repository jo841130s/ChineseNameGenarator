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
import GoogleMobileAds

class HomeViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var middleImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tipsButton: UIButton!
    @IBOutlet var contachUsButton: UIButton!
    let userData = UserData()
    var isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")
    var timer = Timer()
    var degree = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        performSegue(withIdentifier: "startNaming", sender: self)
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

extension UIButton {
    
    func addCorner(radious:CGFloat) {
        self.layer.cornerRadius = radious
    }
}
