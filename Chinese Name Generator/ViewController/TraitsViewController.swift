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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TraitsCell
        var alpha : CGFloat = 0
        if cell.brushImageView.alpha == 0 {
            alpha = 1
        }
        UIView.animate(withDuration: 0.5) {
            cell.brushImageView.alpha = alpha
        }
    }
    


}
