//
//  CountryViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/23.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet var countryPickerView: UIPickerView!
    @IBOutlet var nextButtonView: UIView!
    var selectedCountry = "Australia"
    let userData = UserData()
    
    let countriesArray = ["Australia", "Belgium", "Bulgaria", "Canada", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy", "India", "Indonesia", "Latvia", "Lithuania", "Luxembourg", "Malaysia", "Myanmar", "Malta", "Netherlands", "New Zealand", "Peru", "Philippines", "Poland", "Portugal", "Romania", "Singapore", "Slovakia", "Slovenia", "Spain", "Sweden", "Taiwan", "Thailand", "United Kingdom", "USA", "Vietnam", "Others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButtonView.layer.cornerRadius = 5
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        userData.setUserData(data: selectedCountry, name: "Country")
    }

}

extension CountryViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countriesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if let font = UIFont(name: "LetterGothicStd-Bold", size: 24) {
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = font
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = countriesArray[row]
            pickerLabel?.textColor = UIColor.black
        }
        return pickerLabel!
    }
    
}
