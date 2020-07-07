//
//  PreferenceViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/28.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift
import RealmSwift
import GoogleMobileAds

class PreferenceViewController: UIViewController {
    
    let isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")
    
    @IBOutlet var numCharSegmentedControl: UISegmentedControl!
    @IBOutlet var fixedSurname: UITextField!
    @IBOutlet var fixedFirstChar: UITextField!
    @IBOutlet var fixedSecondChar: UITextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var nextButtonView: UIView!
    @IBOutlet var vidoeImageView: UIImageView!
    
    let usedTimes = UserDefaults.standard.integer(forKey: "UsedTimes")
    
    let userData = UserData()
    let realm = try! Realm()
    
    let apiBuilder = APIBuilder()
    var nameData : NameData?
    var numChars = "3"
    
    var rewardedAd : GADRewardedAd?
    var rewardedADDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if usedTimes == 0 {
            vidoeImageView.isHidden = true
        }
        rewardedAd = createAndLoadRewardedAd()
        nextButtonView.layer.cornerRadius = 5
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        apiBuilder.delegate = self
        setFixedSurnameTextField()
    }
    
    func showRewardedAd() {
        if rewardedAd?.isReady == true {
           rewardedAd?.present(fromRootViewController: self, delegate:self)
        }
    }
    
    @IBAction func numCharValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            numChars = "3"
            fixedFirstChar.isHidden = false
            fixedFirstChar.text = ""
        } else if sender.selectedSegmentIndex == 1 {
            numChars = "2"
            fixedFirstChar.isHidden = true
            fixedFirstChar.text = ""
        }
    }
    
    
    func setFixedSurnameTextField() {
        if isForeigner {
            return
        }
        if let fixedSurnameText = userData.userData(name: "fixed_surname") as? String {
            fixedSurname.text = fixedSurnameText
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if usedTimes == 0 {
            requestName()
        } else {
            showRewardedAd()
        }
        UserDefaults.standard.set(usedTimes+1, forKey: "UsedTimes")
    }
    
    func requestName() {
        let surname = fixedSurname.text ?? ""
        let firstChar = fixedFirstChar.text ?? ""
        let secondChar = fixedSecondChar.text ?? ""
        if !checkTextField(surname: surname, firstChar: firstChar, secondChar: secondChar) {
            return
        }
        userData.setUserData(data: numChars, name: "num_char")
        userData.setUserData(data: surname, name: "fixed_surname")
        userData.setUserData(data: firstChar, name: "fixed_first_char")
        userData.setUserData(data: secondChar, name: "fixed_second_char")
        apiBuilder.requestNameData()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ResultViewController
        controller.namesData = nameData
    }
    
    func checkTextField(surname:String, firstChar:String, secondChar:String) -> Bool {
        if surname.count > 1 || firstChar.count > 1 || secondChar.count > 1 {
            switch isForeigner {
            case true:
                showAlert(message: "Each field can only filled with one character")
            case false:
                showAlert(message: "每個空格只能填寫一個字")
            }
            return false
        } else if containsLetters(input: surname) || containsLetters(input: firstChar) || containsLetters(input: secondChar) {
            switch isForeigner {
            case true:
                showAlert(message: "Each field can only filled with chinese")
            case false:
                showAlert(message: "每個空格只能填寫中文")
            }
            return false
        } else if firstChar != "" && secondChar != "" {
            switch isForeigner {
            case true:
                showAlert(message: "Can't fill all fields")
            case false:
                showAlert(message: "不能填寫所有空格")
            }
            return false
        } else if numChars == "2" && secondChar != "" && fixedSurname.text != "" {
            switch isForeigner {
            case true:
                showAlert(message: "Can't fill all fields")
            case false:
                showAlert(message: "不能填寫所有空格")
            }
            return false
        }
        return true
    }
    
    func showAlert(message:String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func containsLetters(input: String) -> Bool {
       for chr in input {
          if ((chr >= "a" && chr <= "z") || (chr >= "A" && chr <= "Z")) {
             return true
          }
       }
       return false
    }
    
}

extension PreferenceViewController : APIDelegate {
    
    func usedCountReceived(count: Int) {
        print("")
    }
    
    func usedCountNotReceived(error: AFError?) {
        print("")
    }
    
    
    func nameDataReceived(data: NameData) {
        nameData = data
        performSegue(withIdentifier: "goResult", sender: self)
        saveNameDataToHistory(nameData:data)
    }
    
    func nameDataNotReceived(error:AFError?) {
        switch isForeigner {
        case true:
            showAlert(message: "Change the characters you filled in fields")
        case false:
            showAlert(message: "請更改您填寫在空格中的字元，因為您填寫的字元不適用於命名，或是我們尚未將該字元納入命名用字元")
        }
    }
    
    func saveNameDataToHistory(nameData:NameData?) {
        let nameHistoryData = NameHistoryData()
        nameHistoryData.create_time = nameData?.create_time ?? ""
        nameHistoryData.status = nameData?.status ?? ""
        nameHistoryData.message = nameData?.message ?? ""
        do {
            try realm.write{
                realm.add(nameHistoryData)
            }
        } catch {
            print("Error Saving Name Data: \(error)")
        }
        saveSurnames(currentData: nameHistoryData, nameData:nameData)
        saveHistoryNames(currentData: nameHistoryData, nameData:nameData)
        saveChars(currentData: nameHistoryData, nameData:nameData)
    }
    
    func saveSurnames(currentData:NameHistoryData, nameData:NameData?) {
        let dataCount = (nameData?.surnames?.count ?? 1) - 1
        for i in 0...dataCount {
            let newData = HistorySurnames()
            newData.surname = nameData?.surnames?[i] ?? ""
            do {
                try realm.write{
                    currentData.surnames.append(newData)
                }
            } catch {
                print("Error Saving Name Data: \(error)")
            }
        }
    }
    
    func saveHistoryNames(currentData:NameHistoryData, nameData:NameData?) {
        let dataCount = (nameData?.names.count ?? 1) - 1
        for i in 0...dataCount {
            let newData = HistoryNames()
            newData.traditional = nameData?.names[i].traditional ?? ""
            newData.simplified = nameData?.names[i].simplified ?? ""
            newData.num_stroke = nameData?.names[i].num_stroke ?? ""
            newData.goodness = nameData?.names[i].goodness ?? ""
            do {
                try realm.write{
                    currentData.names.append(newData)
                }
            } catch {
                print("Error Saving Name Data: \(error)")
            }
        }
    }
    
    func saveChars(currentData:NameHistoryData, nameData:NameData?) {
        let dataCount = (nameData?.chars.count ?? 1) - 1
        for i in 0...dataCount {
            let newData = HistoryChars()
            newData.traditional = nameData?.chars[i].traditional ?? ""
            newData.simplified = nameData?.chars[i].simplified ?? ""
            newData.chinese = nameData?.chars[i].chinese ?? ""
            newData.english = nameData?.chars[i].english ?? ""
            newData.pinyin = nameData?.chars[i].pinyin ?? ""
            newData.phonetic = nameData?.chars[i].phonetic ?? ""
            newData.stroke = nameData?.chars[i].stroke ?? ""
            newData.radical = nameData?.chars[i].radical ?? ""
            do {
                try realm.write{
                    currentData.chars.append(newData)
                }
            } catch {
                print("Error Saving Name Data: \(error)")
            }
        }
    }
    
}

extension PreferenceViewController : GADRewardedAdDelegate {
    
    func createAndLoadRewardedAd() -> GADRewardedAd? {
        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-4893868639954563/1581391087")
        rewardedAd?.load(GADRequest()) { error in
            if let error = error {
                print("Loading failed: \(error)")
            } else {
                print("Loading Succeeded")
            }
        }
        return rewardedAd
    }
    
    /// Tells the delegate that the user earned a reward.
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        rewardedADDone = true
    }
    
    /// Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        print("Rewarded ad presented.")
    }
    
    /// Tells the delegate that the rewarded ad was dismissed.
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        if rewardedADDone == true {
            rewardedADDone = false
            requestName()
        } else {
            self.rewardedAd = createAndLoadRewardedAd()
        }
    }
    
    /// Tells the delegate that the rewarded ad failed to present.
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print("Rewarded ad failed to present.")
    }
}
