//
//  HistoryViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/7.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var nameArray = ["123","456","789"]
    var timeArray = ["2020/07/09","2020/05/04","2020/01/02"]
    
    @IBOutlet var historyTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        cell.frontImage.image =  UIImage(named: "八卦")
        cell.chineseNameLabel.text = nameArray[indexPath.row]
        cell.timeLabel.text = timeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let nextViewController = NameInformationViewController(chineseName: "黃貫中")
        if #available(iOS 13.0, *) {
            if let nextController = storyboard?.instantiateViewController(identifier: "NameInformationViewController") as? NameInformationViewController {
                nextController.chineseName = nameArray[indexPath.row]
                show(nextController, sender: nil)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
