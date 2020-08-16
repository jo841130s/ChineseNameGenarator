//
//  JSONBuilder.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/5.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation
import Alamofire
import NVActivityIndicatorView

class APIBuilder {
    
    var delegate: APIDelegate?
    let activityIndicator : NVActivityIndicatorView
    var blackView = UIView()
    var device_id = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    init() {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let frame = CGRect(x: (screenWidth-60)/2, y: (screenHeight-60)/2, width: 60, height: 60)
        let types : [NVActivityIndicatorType] = [.audioEqualizer, .ballBeat, .ballClipRotate, .ballClipRotateMultiple, .ballClipRotatePulse, .ballDoubleBounce, .ballGridBeat ,.ballGridPulse, .ballPulse, .ballPulseRise, .ballPulseSync, .ballRotate, .ballRotateChase, .ballScale, .ballScaleMultiple, .ballScaleRipple, .ballScaleRippleMultiple, .ballSpinFadeLoader, .ballTrianglePath, .ballZigZag, .ballZigZagDeflect, .circleStrokeSpin, .cubeTransition, .lineScale, .lineScaleParty, .lineScalePulseOut, .lineScalePulseOutRapid, .lineSpinFadeLoader, .orbit, .pacman, .semiCircleSpin, .squareSpin, .triangleSkewSpin]
        let randomNum = Int.random(in: 0..<types.count)
        let type = types[randomNum]
        activityIndicator = NVActivityIndicatorView(frame: frame, type: type, color: .white, padding: 10)
        
        blackView.frame = UIScreen.main.bounds
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        blackView.addSubview(activityIndicator)
        device_id = device_id+"Chinese"
    }
    
    func startLoading() {
        UIApplication.shared.keyWindow?.addSubview(blackView)
        activityIndicator.startAnimating()
    }
    
    func endLoading() {
        activityIndicator.stopAnimating()
        blackView.removeFromSuperview()
    }

    
    func requestNameData() {
        startLoading()
        AF.request(requestURL()).response(completionHandler: { (response) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = response.data, let namesData = try? decoder.decode(NameData.self, from: data) {
                self.delegate?.nameDataReceived(data: namesData)
            } else {
                self.delegate?.nameDataNotReceived(error: response.error)
            }
            self.endLoading()
        })
    }
    
    func requestUsedCount() {
        startLoading()
        AF.request("https://sinoname.appspot.com/used_count?device_id=\(device_id)").response(completionHandler: { (response) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let data = response.data, let usedCountData = try? decoder.decode(UsedCountData.self, from: data) {
                self.delegate?.usedCountReceived(count: Int(usedCountData.used_count) ?? 0)
            } else {
                self.delegate?.usedCountNotReceived(error: response.error)
            }
            self.endLoading()
        })
    }
    
    func requestURL() -> String {
        let url = "https://sinoname.appspot.com/create_name?"
        let gender = UserData.userData(name: "Gender") as! String
        var given_name = ""
        var country = ""
        var surname = ""
        if UserData.isForeigner {
            surname = UserData.userData(name: "FirstName") as! String
            given_name = UserData.userData(name: "LastName") as! String
            country = UserData.userData(name: "Country") as! String
        }
        let birthday = UserData.userData(name: "Birth") as! String
        let traits = UserData.userData(name: "Traits") as! [String]
        let num_char = UserData.userData(name: "num_char") as! String
        let fixed_surname = UserData.userData(name: "fixed_surname") as! String
        let fixed_first_char = UserData.userData(name: "fixed_first_char") as! String
        let fixed_second_char = UserData.userData(name: "fixed_second_char") as! String
        
        var traitString = ""
        for trait in traits {
            traitString.append("&trait=\(trait)")
        }
        if UserData.isForeigner {
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
    
}

protocol APIDelegate {
    func nameDataReceived(data:NameData)
    func nameDataNotReceived(error:AFError?)
    
    func usedCountReceived(count:Int)
    func usedCountNotReceived(error:AFError?)
}
