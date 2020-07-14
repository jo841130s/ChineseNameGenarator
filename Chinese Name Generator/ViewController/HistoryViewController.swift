//
//  HistoryViewController.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/7.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleMobileAds

class HistoryViewController: UIViewController {
    
    let realm = try! Realm()
    
    var nameArray : [String] = []
    var timeArray : [String] = []
    var charsData : [Chars] = []
    var selectedRow = 0
    
    @IBOutlet var historyTableView: UITableView!
    @IBOutlet var adView: UIView!
    
    var bannerView : GADBannerView!
    
    override func viewWillAppear(_ animated: Bool) {
        setupBannerAD()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        loadHistoryNames()
    }
    
    func setupBannerAD() {
        if bannerView != nil {
            bannerView.removeFromSuperview()
        }
        let adSize = GADAdSizeFromCGSize(CGSize(width: UIScreen.main.bounds.size.width, height: adView.frame.height))
        bannerView = GADBannerView(adSize: adSize)
        bannerView.delegate = self
        adView.addSubview(bannerView)
        bannerView.adUnitID = "ca-app-pub-4893868639954563/1722961505"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
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
        timeArray = timeArray.reversed()
        nameArray = nameArray.reversed()
        charArray = charArray.reversed()
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
        cell.chineseNameLabel.text = nameArray[indexPath.row]
        cell.timeLabel.text = timeArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "goNameInfo", sender: self)
    }
    
}

extension HistoryViewController : GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        adView.isHidden = true
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
