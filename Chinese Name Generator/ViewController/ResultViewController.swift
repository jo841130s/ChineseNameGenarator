//
//  ResultViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/2.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import RealmSwift

class ResultViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var homeButton: UIButton!
    var namesData : NameData?
    var selectedRow = 0
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeButton.addCorner(radious: 5)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! NameInformationViewController
        controller.chineseName = namesData?.names[selectedRow].traditional
        controller.charsData = namesData?.chars
    }
    
}

extension ResultViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesData?.names.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
        cell.nameLabel.text = namesData?.names[indexPath.row].traditional
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goNameInformation", sender: self)
    }
    
    
}
