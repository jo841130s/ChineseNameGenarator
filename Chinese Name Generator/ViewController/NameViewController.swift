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
        userData.setUserData(data: firstNameTextField.text ?? "", name: "FirstName")
        userData.setUserData(data: lastNameTextField.text ?? "", name: "LastName")
    }
    
}
