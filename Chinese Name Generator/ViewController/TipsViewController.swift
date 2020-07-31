//
//  TipsViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/7.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let chineseTipsText = ["根據統計分析，姓名不僅是代表一個人的符號，姓名對於人的健康、性格、事業、婚姻和人際關係影響很大。","寶寶起名智能妙算app系統，本著為寶寶起個好名的使命感，根據您輸入的資料，用心參考總筆畫數姓名學、十二生肖姓名學，並且利用人工智慧演算，幫寶寶起個字義美好、讀音順口、好寫、好記、好看的名字。","期許能為您取個吉祥如意的好名字！"]
    
    let foreignerTipsText = ["More than 90% of Chinese names consist of two or three Chinese characters - the first character represents surname (last name), typically same with the father side; the second and third characters represent names carrying family expectation towards the kid. Sometimes, all children belonging to a family tree are pre-assigned in part of their names to show their seniority relationship.","Our app attempts to help you on this by employing state-of-the-art information technologies and Chinese fortune telling statistics. The app provides a list of Chinese name suggestions, with two or three Chinese characters, based on your app inputs including your name, gender, birth date and country, and your expectation. We will store the name suggestions in the historical record for your later retrieval and consideration.","In the app, your Chinese name would be shown in traditional Chinese characters along with an explanation and sound player for each Chinese character to help you choose and even interact with Chinese friends for your final choice."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        if isForeigner {
//            tableView.register(UINib(nibName: "TipCell", bundle: nil), forCellReuseIdentifier: "TipCell")
//        } else {
            tableView.register(UINib(nibName: "TipsCell", bundle: nil), forCellReuseIdentifier: "TipsCell")
//        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension TipsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch UserData.isForeigner {
        case true:
            return foreignerTipsText.count
        case false:
            return chineseTipsText.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipsCell", for: indexPath) as! TipsCell
            
        switch UserData.isForeigner {
        case true:
            cell.tipLabal.text = foreignerTipsText[indexPath.row]
            cell.tipLabal.font = UIFont(name: "Centaur", size: 18)
        case false:
            cell.tipLabal.text = chineseTipsText[indexPath.row]
        }
        return cell
    }
    
      
}
