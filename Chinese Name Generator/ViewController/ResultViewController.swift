//
//  ResultViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/2.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var namesData : NameData?
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! NameInformationViewController
        controller.chineseName = namesData?.names[selectedRow].traditional
        controller.charsData = namesData?.chars
    }
    
}

extension ResultViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
        cell.nameLabel.text = namesData?.names[indexPath.row].traditional
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "goNameInformation", sender: self)
    }
    
    
}
