//
//  TraitsViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/23.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class TraitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var traits = ["Artful","Beatiful","Handsome","Clever","Calm","Diligent","Elegant","Excellent","Friendly","Happy","Healthy","Lucky","Powerful","Rich","Virtous","Wise"]
    var isSelected = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TraitsCell", bundle: nil), forCellReuseIdentifier: "TraitsCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return traits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TraitsCell", for: indexPath) as! TraitsCell
        cell.traitLabel.text = traits[indexPath.row]
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
        tableView.reloadData()
    }
    
    func userTraits() -> [String] {
        var userTraits : [String] = []
        for i in 0...traits.count-1 {
            if isSelected[i] {
                userTraits.append(traits[i])
            }
        }
        return userTraits
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserData().setUserData(data: userTraits(), name: "Traits")
    }
    
}
