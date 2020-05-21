//
//  JSONBuilder.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/5.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation
import Alamofire
import EZProgressHUD

class APIBuilder {
    
    var delegate: APIDelegate?
    
    let isForeigner = UserDefaults.standard.bool(forKey: "isForeigner")
    
    func requestNameData() {
        let options = progressOption()
        let hud = EZProgressHUD.setProgress(with: options)
        hud.show()
        AF.request(requestURL()).response(completionHandler: { (response) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = response.data, let namesData = try? decoder.decode(NameData.self, from: data) {
                self.delegate?.nameDataReceived(data: namesData)
            } else {
                self.delegate?.nameDataNotReceived(error: response.error)
            }
            hud.dismiss(completion: nil)
        })
    }
    
    func requestUsedCount() {
        AF.request("https://sinoname.appspot.com/used_count?device_id=\(UIDevice.current.identifierForVendor?.uuidString ?? "")").response(completionHandler: { (response) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
//            print(String(data: response.data!, encoding: .utf8))
            if let data = response.data, let usedCountData = try? decoder.decode(UsedCountData.self, from: data) {
                self.delegate?.usedCountReceived(count: Int(usedCountData.used_count) ?? 0)
            } else {
                self.delegate?.usedCountNotReceived(error: response.error)
            }
        })
    }
    
    func requestURL() -> String {
        let url = "https://sinoname.appspot.com/create_name?"
        let userData = UserData()
        let device_id = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let gender = userData.userData(name: "Gender") as! String
        var given_name = ""
        var country = ""
        var surname = ""
        if isForeigner {
            surname = userData.userData(name: "FirstName") as! String
            given_name = userData.userData(name: "LastName") as! String
            country = userData.userData(name: "Country") as! String
        }
        let birthday = userData.userData(name: "Birth") as! String
        let traits = userData.userData(name: "Traits") as! [String]
        let num_char = userData.userData(name: "num_char") as! String
        let fixed_surname = userData.userData(name: "fixed_surname") as! String
        let fixed_first_char = userData.userData(name: "fixed_first_char") as! String
        let fixed_second_char = userData.userData(name: "fixed_second_char") as! String
        
        var traitString = ""
        for trait in traits {
            traitString.append("&trait=\(trait)")
        }
        if isForeigner {
            let enHeader = "device_id=\(device_id)&platform=iOS&app_version=1.0.1&gender=\(gender)&surname=\(surname)&given_name=\(given_name)&country=\(country)&birthday=\(birthday)&num_char=\(num_char)&fixed_surname=\(fixed_surname)&fixed_first_char=\(fixed_first_char)&fixed_second_char=\(fixed_second_char)\(traitString)"
            let enUrl = "\(url)\(enHeader)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return enUrl
        } else {
            let cnHeader = "device_id=\(device_id)&platform=iOS&app_version=1.0.1&gender=\(gender)&given_name=\(given_name)&country=China&birthday=\(birthday)&num_char=\(num_char)&fixed_surname=\(fixed_surname)&fixed_first_char=\(fixed_first_char)&fixed_second_char=\(fixed_second_char)\(traitString)&output_language=chinese"
            let cnUrl = "\(url)\(cnHeader)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            print(cnUrl)
            return cnUrl
        }
    }
    
    func progressOption() -> EZProgressOptions {
        let options = EZProgressOptions { (option) in
            option.radius = 117
            option.secondLayerStrokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            option.strokeWidth = 12
            option.thirdLayerStrokeColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            option.firstLayerStrokeColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            option.title = "Loading..."
            option.animationOption = EZAnimationOptions.lordOfTheRings
        }
        return options
    }
    
}

protocol APIDelegate {
    func nameDataReceived(data:NameData)
    func nameDataNotReceived(error:AFError?)
    
    func usedCountReceived(count:Int)
    func usedCountNotReceived(error:AFError?)
}
