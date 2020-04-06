//
//  JSONBuilder.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/5.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation
import Alamofire

class JSONBuilder {
    
    var delegate: JsonDelegate?
    
    func requestNameData() {
        AF.request(requestURL()).response(completionHandler: { (response) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = response.data, let namesData = try?
                decoder.decode(NameData.self, from: data)
            {
//                print(namesData)
                self.delegate?.nameDataReceived(data: namesData)
            } else {
                print("error")
                print(response)
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
//        let country = userData.userData(name: "Country") as! String
        let country = "Taiwan"
        let birthday = userData.userData(name: "Birth") as! String
        let traits = userData.userData(name: "Traits") as! [String]
        var traitString = ""
        for trait in traits {
            traitString.append("&trait=\(trait)")
        }
        let header = "device_id=\(device_id)&platform=iOS&app_version=1.0.1&gender=\(gender)&surname=\(surname)&given_name=\(given_name)&country=\(country)&birthday=\(birthday)&num_char=3&fixed_surname=&fixed_first_char=&fixed_second_char=\(traitString)"
        return "\(url)\(header)"
    }
    
}

protocol JsonDelegate {
    func nameDataReceived(data:NameData)
    func nameDataNotReceived()
}
