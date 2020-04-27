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

class PreferenceViewController: UIViewController {
    
    let isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")

    @IBOutlet var tableView: UITableView!
    @IBOutlet var fixedSurname: UITextField!
    @IBOutlet var fixedFirstChar: UITextField!
    @IBOutlet var fixedSecondChar: UITextField!
    
    var enCellTitle = ["Two","Three"]
    var cnCellTitle = ["兩個字","三個字"]
    let jsonBuilder = JSONBuilder()
    var nameData : NameData?
    var numChars = "3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        jsonBuilder.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let userData = UserData()
        userData.setUserData(data: numChars, name: "num_char")
//        let surname = fixedSurname.text ?? ""
        let firstChar = fixedFirstChar.text ?? ""
        let secondChar = fixedSecondChar.text ?? ""
//        userData.setUserData(data: surname, name: "fixed_surname")
        userData.setUserData(data: firstChar, name: "fixed_first_char")
        userData.setUserData(data: secondChar, name: "fixed_second_char")
        jsonBuilder.requestNameData()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ResultViewController
        controller.namesData = nameData
    }
    
}

extension PreferenceViewController : JsonDelegate {
    
    func nameDataReceived(data: NameData) {
        nameData = data
        performSegue(withIdentifier: "goResult", sender: self)
    }
    
    func nameDataNotReceived(error:AFError?) {
        print("data not received, error: \(String(describing: error))")
    }
    
}

extension PreferenceViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if isForeigner {
            cell.textLabel?.text = enCellTitle[indexPath.row]
        } else {
            cell.textLabel?.text = cnCellTitle[indexPath.row]
        }
        cell.selectionStyle = .default
        cell.selectedBackgroundView?.backgroundColor = .lightGray
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if row == 0 {
            numChars = "2"
        } else {
            numChars = "3"
        }
        
    }
    
}
