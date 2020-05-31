//
//  HoroscopeStoryViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/5/23.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class HoroscopeStoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var horoscopeName: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var viewTitle = "viewTitle"
    var cellText = "cellText"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horoscopeName.text = viewTitle
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let attributedString = NSMutableAttributedString(string: cellText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        cell.textLabel?.attributedText = attributedString
        if let font = UIFont(name: "圓體-簡 細體", size: 24) {
            cell.textLabel?.font = font
        }
        
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
