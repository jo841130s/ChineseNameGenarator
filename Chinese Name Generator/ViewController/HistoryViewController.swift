//
//  HistoryViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/7.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryViewController: UIViewController {
    
    let realm = try! Realm()
    
    var nameArray : [String] = []
    var timeArray : [String] = []
    var charsData : [Chars] = []
    var selectedRow = 0
    
    @IBOutlet var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        loadHistoryNames()
    }
    
    func loadHistoryNames() {
        var charArray : [HistoryChars] = []
        let data = realm.objects(NameHistoryData.self)
        if data.count == 0 { return }
        for i in 0..<data.count {
            for _ in 0..<data[i].names.count {
                timeArray.append(data[i].create_time)
            }
            for j in 0..<data[i].names.count {
                nameArray.append(data[i].names[j].traditional)
            }
            for k in 0..<data[i].chars.count {
                charArray.append(data[i].chars[k])
            }
        }
        decodeHistoryChars(data: charArray)
        historyTableView.reloadData()
    }
    
    func decodeHistoryChars(data:[HistoryChars]) {
        for i in 0..<data.count {
            let traditional = data[i].traditional
            let simplified = data[i].simplified
            let chinese = data[i].chinese
            let english = data[i].english
            let pinyin = data[i].pinyin
            let phonetic = data[i].phonetic
            let stroke = data[i].stroke
            let radical = data[i].radical
            let newData = Chars(traditional: traditional, simplified: simplified, chinese: chinese, english: english, pinyin: pinyin, phonetic: phonetic, stroke: stroke, radical: radical)
            charsData.append(newData)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! NameInformationViewController
        controller.chineseName = nameArray[selectedRow]
        controller.charsData = charsData
    }
    
}

extension HistoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        cell.frontImage.image =  UIImage(named: "八卦")
        cell.chineseNameLabel.text = nameArray[indexPath.row]
        cell.timeLabel.text = timeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "goNameInfo", sender: self)
    }
    
}
