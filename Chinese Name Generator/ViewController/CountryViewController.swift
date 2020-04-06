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
    
    let countriesArray = ["Australia", "Belgium", "Bulgaria", "Canada", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy", "India", "Indonesia", "Latvia", "Lithuania", "Luxembourg", "Malaysia", "Myanmar", "Malta", "Netherlands", "New Zealand", "Peru", "Philippines", "Poland", "Portugal", "Romania", "Singapore", "Slovakia", "Slovenia", "Spain", "Sweden", "Taiwan", "Thailand", "United Kingdom", "USA", "Vietnam", "Others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let selectedNum = countryPickerView.selectedRow(inComponent: 0)
        UserData().setUserData(data: countriesArray[selectedNum], name: "Counrty")
    }

}

extension CountryViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countriesArray[row]
    }
    
}
