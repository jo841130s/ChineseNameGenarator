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
    var namesData : NameData?
    var selectedRow = 0
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        saveNameDataToHistory()
    }
    
    func saveNameDataToHistory() {
        let nameHistoryData = NameHistoryData()
        nameHistoryData.create_time = namesData?.create_time ?? ""
        nameHistoryData.status = namesData?.status ?? ""
        nameHistoryData.message = namesData?.message ?? ""
        do {
            try realm.write{
                realm.add(nameHistoryData)
            }
        } catch {
            print("Error Saving Name Data: \(error)")
        }
        saveSurnames(currentData: nameHistoryData)
        saveHistoryNames(currentData: nameHistoryData)
        saveChars(currentData: nameHistoryData)
    }
    
    func saveSurnames(currentData:NameHistoryData) {
        let dataCount = (namesData?.surnames?.count ?? 1) - 1
        for i in 0...dataCount {
            let newData = HistorySurnames()
            newData.surname = namesData?.surnames?[i] ?? ""
            do {
                try realm.write{
                    currentData.surnames.append(newData)
                }
            } catch {
                print("Error Saving Name Data: \(error)")
            }
        }
    }
    
    func saveHistoryNames(currentData:NameHistoryData) {
        let dataCount = (namesData?.names.count ?? 1) - 1
        for i in 0...dataCount {
            let newData = HistoryNames()
            newData.traditional = namesData?.names[i].traditional ?? ""
            newData.simplified = namesData?.names[i].simplified ?? ""
            newData.num_stroke = namesData?.names[i].num_stroke ?? ""
            newData.goodness = namesData?.names[i].goodness ?? ""
            do {
                try realm.write{
                    currentData.names.append(newData)
                }
            } catch {
                print("Error Saving Name Data: \(error)")
            }
        }
    }
    
    func saveChars(currentData:NameHistoryData) {
        let dataCount = (namesData?.chars.count ?? 1) - 1
        for i in 0...dataCount {
            let newData = HistoryChars()
            newData.traditional = namesData?.chars[i].traditional ?? ""
            newData.simplified = namesData?.chars[i].simplified ?? ""
            newData.chinese = namesData?.chars[i].chinese ?? ""
            newData.english = namesData?.chars[i].english ?? ""
            newData.pinyin = namesData?.chars[i].pinyin ?? ""
            newData.phonetic = namesData?.chars[i].phonetic ?? ""
            newData.stroke = namesData?.chars[i].stroke ?? ""
            newData.radical = namesData?.chars[i].radical ?? ""
            do {
                try realm.write{
                    currentData.chars.append(newData)
                }
            } catch {
                print("Error Saving Name Data: \(error)")
            }
        }
    }
    
    func startTimerForShowScrollIndicator() {
        _ = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.showScrollIndicatorsInContacts), userInfo: nil, repeats: true)
    }
    
    @objc func showScrollIndicatorsInContacts() {
        UIView.animate(withDuration: 0.001) {
            self.tableView.flashScrollIndicators()
        }
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
