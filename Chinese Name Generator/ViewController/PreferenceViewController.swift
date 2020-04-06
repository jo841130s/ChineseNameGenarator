//
//  PreferenceViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/28.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import Alamofire

class PreferenceViewController: UIViewController, JsonDelegate {

    @IBOutlet var tableView: UITableView!
    var cellTitle = ["123","234","456"]
    let jsonBuilder = JSONBuilder()
    var nameData : NameData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonBuilder.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        UserData().setUserData(data: 3, name: "Name")
        jsonBuilder.requestNameData()
    }
    
    func nameDataReceived(data: NameData) {
        nameData = data
        performSegue(withIdentifier: "goResult", sender: self)
    }
    
    func nameDataNotReceived() {
        print("data not received")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ResultViewController
        controller.namesData = nameData
    }
    
}

extension PreferenceViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cellTitle[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
