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
    
    var chineseName : String?
    var charsData : [Chars]?
    var sortedCharsData : [Chars] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chineseNameLabel.text = chineseName
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NameInformationCell", bundle: nil), forCellReuseIdentifier: "NameInformationCell")
        sortCharsData(data: charsData)
    }
    
    func sortCharsData(data:[Chars]?) {
        let chineseNameLength = (chineseName?.count ?? 1) - 1
        for i in 0...chineseNameLength {
            let char = chineseName?[i] ?? ""
            if let charData = findChar(char: char, in: data) {
                sortedCharsData.append(charData)
            }
        }
        tableView.reloadData()
    }
    
    func findChar(char:String, in data:[Chars]?) -> Chars? {
        let charsDataCount = (data?.count ?? 1) - 1
        for i in 0...charsDataCount {
            if data?[i].traditional == char {
                return data?[i]
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedCharsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameInformationCell", for: indexPath) as! NameInformationCell
        let data = sortedCharsData[indexPath.row]
        cell.charLabel.text = data.traditional
        cell.englishSoundLabel.text = data.pinyin
        cell.meaningLabel.text = data.chinese
        cell.strokeLabel.text = data.stroke
        return cell
    }

    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
