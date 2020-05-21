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

class HomeViewController: UIViewController {

    @IBOutlet var homePageTitle: UILabel!
    @IBOutlet weak var middleImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var tipsButton: UIButton!
    let userData = UserData()
    let isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")
    var apiBuilder = APIBuilder()
    var timer = Timer()
    var degree = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiBuilder.delegate = self
        spinMiddleImage()
        setButton(button: startButton)
        setButton(button: historyButton)
        setButton(button: tipsButton)
        if homePageTitle.text == "寶寶起名" {
            userData.setUserData(data: false, name: "isForeigner")
        } else {
            userData.setUserData(data: true, name: "isForeigner")
        }
        
    }
    
    func spinMiddleImage(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(spinAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func spinAnimation() {
        degree += 0.005
        middleImage.transform = CGAffineTransform(rotationAngle: CGFloat(degree))
    }
    
    func setButton(button:UIButton) {
        button.addCorner(radious: 5)
    }

    @IBAction func startButtonPressed(_ sender: Any) {
        apiBuilder.requestUsedCount()
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
        print(count)
//        if count <= 5 {
            performSegue(withIdentifier: "startNaming", sender: self)
//        } else {
//            switch isForeigner {
//            case true:
//                reachUsedLimitAlert(title: "Reach used limit!", message: "You could buy 5 times for 1 US dollar")
//            case false:
//                reachUsedLimitAlert(title: "使用次數達到上限", message: "您可以花費 1 美元增加五次使用次數")
//            }
//        }
    }
    
    func usedCountNotReceived(error: AFError?) {
        print("")
    }
    
    func reachUsedLimitAlert(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        var chargeAction = UIAlertAction(title: "購買", style: .default) { (action) in
            
        }
        if isForeigner {
            cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            chargeAction = UIAlertAction(title: "Buy", style: .default) { (action) in
                
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(chargeAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension UIButton {
    
    func addCorner(radious:CGFloat) {
        self.layer.cornerRadius = radious
    }
}
