//
//  SettingViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/7.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "SettingCell")
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
