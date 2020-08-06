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

class PreferenceViewController: UIViewController {
    
    @IBOutlet var numCharSegmentedControl: UISegmentedControl!
    @IBOutlet var fixedSurname: UITextField!
    @IBOutlet var fixedFirstChar: UITextField!
    @IBOutlet var fixedSecondChar: UITextField!
    @IBOutlet var nextButton: UIButton!
    
    let realm = try! Realm()
    
    let apiBuilder = APIBuilder()
    var nameData : NameData?
    var numChars = "3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixedSurname.delegate = self
        fixedFirstChar.delegate = self
        fixedSecondChar.delegate = self
        fixedSurname.backgroundColor = .white
        fixedFirstChar.backgroundColor = .white
        fixedSecondChar.backgroundColor = .white
        nextButton.addCorner(radious: 5)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        apiBuilder.delegate = self
        setFixedSurnameTextField()
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
        if UserData.isForeigner {
            return
        }
        if let fixedSurnameText = UserData.userData(name: "fixed_surname") as? String {
            fixedSurname.text = fixedSurnameText
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        requestName()
    }
    
    func requestName() {
        let surname = fixedSurname.text ?? ""
        let firstChar = fixedFirstChar.text ?? ""
        let secondChar = fixedSecondChar.text ?? ""
        if !checkTextField(surname: surname, firstChar: firstChar, secondChar: secondChar) {
            return
        }
        UserData.setUserData(data: numChars, name: "num_char")
        UserData.setUserData(data: surname, name: "fixed_surname")
        UserData.setUserData(data: firstChar, name: "fixed_first_char")
        UserData.setUserData(data: secondChar, name: "fixed_second_char")
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
            switch UserData.isForeigner {
            case true:
                showAlert(title: "Error", message: "Each field can only filled with one character")
            case false:
                showAlert(title: "Error", message: "每個空格只能填寫一個字")
            }
            return false
        } else if containsLetters(input: surname) || containsLetters(input: firstChar) || containsLetters(input: secondChar) {
            switch UserData.isForeigner {
            case true:
                showAlert(title: "Error", message: "Each field can only filled with chinese")
            case false:
                showAlert(title: "Error", message: "每個空格只能填寫中文")
            }
            return false
        } else if firstChar != "" && secondChar != "" {
            switch UserData.isForeigner {
            case true:
                showAlert(title: "Error", message: "Can't fill all fields")
            case false:
                showAlert(title: "Error", message: "不能填寫所有空格")
            }
            return false
        } else if numChars == "2" && secondChar != "" && fixedSurname.text != "" {
            switch UserData.isForeigner {
            case true:
                showAlert(title: "Error", message: "Can't fill all fields")
            case false:
                showAlert(title: "Error", message: "不能填寫所有空格")
            }
            return false
        }
        return true
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
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
        if IAPManager.buyTimes() > 0 {
            nameData = data
        } else {
            var unremovedData = data
            unremovedData.names.remove(at: 7)
            unremovedData.names.remove(at: 6)
            unremovedData.names.remove(at: 4)
            unremovedData.names.remove(at: 3)
            unremovedData.names.remove(at: 1)
            unremovedData.names.remove(at: 0)
            nameData = unremovedData
        }
        saveNameDataToHistory(nameData:nameData)
        performSegue(withIdentifier: "goResult", sender: self)
    }
    
    func nameDataNotReceived(error:AFError?) {
        switch UserData.isForeigner {
        case true:
            showAlert(title: "Service Error", message: "Try to change the characters you filled in fields")
        case false:
            showAlert(title: "Service Error", message: "請嘗試更改您填寫在空格中的字元，可能因為您填寫的字元不適用於命名，或是我們尚未將該字元納入命名用字元")
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

extension PreferenceViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
