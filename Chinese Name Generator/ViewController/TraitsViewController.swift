//
//  TraitsViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/23.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class TraitsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")
    
    var enTraits = ["Artful","Beautiful","Handsome","Clever","Calm","Diligent","Elegant","Excellent","Friendly","Happy","Healthy","Lucky","Powerful","Rich","Virtuous","Wise"]
    
    var cnTraits = ["藝術","美麗","英俊","聰明","平和","勤奮","優雅","完美","友善","快樂","健康","幸運","力量","富有","道德","智慧"]
    
    var isSelected = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    var userTraits : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TraitsCell", bundle: nil), forCellReuseIdentifier: "TraitsCell")
        startTimerForShowScrollIndicator()
    }
    
    func startTimerForShowScrollIndicator() {
        _ = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.showScrollIndicatorsInContacts), userInfo: nil, repeats: true)
    }
    
    @objc func showScrollIndicatorsInContacts() {
        UIView.animate(withDuration: 0.001) {
            self.tableView.flashScrollIndicators()
        }
    }
    
    func setUserTraits() {
        userTraits = []
        for i in 0...enTraits.count-1 {
            if isSelected[i] {
                userTraits.append(enTraits[i])
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setUserTraits()
        UserData().setUserData(data: userTraits, name: "Traits")
        print(userTraits)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if userTraits.count == 0 && isForeigner {
            showAlert(message: "Not selected yet")
        } else if userTraits.count == 0 && !isForeigner {
            showAlert(message: "請選擇至少一個")
        } else if userTraits.count > 5 && !isForeigner{
            showAlert(message: "不得超過五個")
        } else if userTraits.count > 5 {
            showAlert(message: "Select over limit")
        } else {
            performSegue(withIdentifier: "goPreference", sender: self)
        }
    }
    
    func showAlert(message:String) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension TraitsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enTraits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TraitsCell", for: indexPath) as! TraitsCell
        if isForeigner {
            cell.traitLabel.text = enTraits[indexPath.row]
        } else {
            cell.traitLabel.text = cnTraits[indexPath.row]
        }
        cell.selectionStyle = .none
        if isSelected[indexPath.row] {
            cell.brushImageView.image = #imageLiteral(resourceName: "brush")
        } else {
            cell.brushImageView.image = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSelected[indexPath.row] = !isSelected[indexPath.row]
        setUserTraits()
        tableView.reloadData()
    }
    
}
