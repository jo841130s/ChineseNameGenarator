//
//  NameViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/23.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class NameViewController: UIViewController {

    @IBOutlet var nextButton: UIButton!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    let userData = UserData()
    let isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")
    
    var banCharacters = "[`~!#$^&*()=|{}':;',\\[\\].<>/?~！#￥……&*（）——|{}【】‘；：”“'。，、？]‘'0123456789"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.addCorner(radious: 5)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let firstName = (firstNameTextField.text ?? "Gill Sans ").trimmingCharacters(in: .whitespaces)
        if !isForeigner {
            userData.setUserData(data: firstName, name: "fixed_surname")
            return
        }
        let lastName = (lastNameTextField.text ?? "").trimmingCharacters(in: .whitespaces)
        userData.setUserData(data: lastName, name: "LastName")
        userData.setUserData(data: firstName, name: "FirstName")
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let firstName = firstNameTextField.text ?? ""
        
        if isForeigner {
            let lastName = lastNameTextField.text ?? ""
            checkFieldIsForeigner(firstName: firstName, lastName: lastName)
        } else {
            checkFieldNotForeigner(firstName: firstName)
        }
    }
    
    func checkFieldNotForeigner(firstName:String) {
        if firstName == "" {
            showAlert(message: "請填寫姓氏")
        } else if !checkName(name: firstName) || containsLetters(input: firstName) {
            showAlert(message: "不可填入特殊字元或英文")
        } else if firstName.count > 1 {
            showAlert(message: "只能填寫一個字")
        } else {
            performSegue(withIdentifier: "goBirthday", sender: self)
        }
    }
    
    func checkFieldIsForeigner(firstName:String, lastName:String) {
        if firstName == "" || lastName == "" {
            showAlert(message: "Please fill in both fields")
        } else if !checkName(name: firstName) || !checkName(name: lastName) {
            showAlert(message: "Do not use special characters or numbers")
        } else {
            performSegue(withIdentifier: "goCountry", sender: self)
        }
    }
    
    func checkName(name:String) -> Bool {
        for i in 0..<name.count {
            let char = name[i]
            for j in 0...banCharacters.count-1 {
                if char == banCharacters[j] {
                    return false
                }
            }
        }
        return true
    }
    
    func containsLetters(input: String) -> Bool {
       for chr in input {
          if ((chr >= "a" && chr <= "z") || (chr >= "A" && chr <= "Z") ) {
             return true
          }
       }
       return false
    }
    
    func showAlert(message:String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
