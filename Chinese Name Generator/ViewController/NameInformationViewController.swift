//
//  NameInformationViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/15.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class NameInformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var chineseNameLabel: UILabel!
    
    var chineseName = ""
    var howToRead : [String]?
    var basicInfo : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        howToRead = ["黃 Huang","冠 Kuan","中 Chung"]
        basicInfo = [""]
        chineseNameLabel.text = chineseName
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return howToRead?.count ?? 0
        case 1:
            return basicInfo?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = howToRead?[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = basicInfo?[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "How to Read"
        case 1:
            return "Meaning"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
