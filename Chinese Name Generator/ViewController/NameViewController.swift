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

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    var banCharacters = "[`~!#$^&*()=|{}':;',\\[\\].<>/?~！#￥……&*（）——|{}【】‘；：”“'。，、？]‘'0123456789"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let userData = UserData()
        let firstName = (firstNameTextField.text ?? "").trimmingCharacters(in: .whitespaces)
        let lastName = (lastNameTextField.text ?? "").trimmingCharacters(in: .whitespaces)
        userData.setUserData(data: firstName, name: "FirstName")
        userData.setUserData(data: lastName, name: "LastName")
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        if firstName == "" || lastName == "" {
            showAlert(message: "Fill both fields")
        } else if !checkName(name: firstName) || !checkName(name: lastName) {
            showAlert(message: "With special characters or numbers")
        } else {
            performSegue(withIdentifier: "goCountry", sender: self)
        }
    }
    
    func checkName(name:String) -> Bool {
        for i in 0...name.count-1{
            let char = name[i]
            for j in 0...banCharacters.count-1 {
                if char == banCharacters[j] {
                    return false
                }
            }
        }
        return true
    }
    
    func showAlert(message:String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}
