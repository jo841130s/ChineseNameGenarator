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

class JSONBuilder {
    
    var delegate: JsonDelegate?
    
    func requestNameData() {
        let options = progressOption()
        let hud = EZProgressHUD.setProgress(with: options)
        hud.show()
        AF.request(requestURL()).response(completionHandler: { (response) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = response.data, let namesData = try?
                decoder.decode(NameData.self, from: data)
            {
                hud.dismiss(completion: nil)
                self.delegate?.nameDataReceived(data: namesData)
            } else {
                hud.dismiss(completion: nil)
                self.delegate?.nameDataNotReceived(error: response.error)
            }
        })
        
    }
    
    func requestURL() -> String {
        let url = "https://sinoname.appspot.com/create_name?"
        let userData = UserData()
        let device_id = UUID().uuidString
        let gender = userData.userData(name: "Gender") as! String
        let surname = userData.userData(name: "FirstName") as! String
        let given_name = userData.userData(name: "LastName") as! String
        let country = userData.userData(name: "Country") as! String
        let birthday = userData.userData(name: "Birth") as! String
        let traits = userData.userData(name: "Traits") as! [String]
        var traitString = ""
        for trait in traits {
            traitString.append("&trait=\(trait)")
        }
        let header = "device_id=\(device_id)&platform=iOS&app_version=1.0.1&gender=\(gender)&surname=\(surname)&given_name=\(given_name)&country=\(country)&birthday=\(birthday)&num_char=3&fixed_surname=&fixed_first_char=&fixed_second_char=\(traitString)"
        return "\(url)\(header)"
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

protocol JsonDelegate {
    func nameDataReceived(data:NameData)
    func nameDataNotReceived(error:AFError?)
}
