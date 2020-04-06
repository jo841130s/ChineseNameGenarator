//
//  UserData.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/28.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

class UserData {
    
    let userDefaults = UserDefaults.standard
    var isForeigner : Bool?
    
    init() {
        isForeigner = userDefaults.bool(forKey: "isForeigner")
    }
    
    func setUserData(data:Any,name:String) {
        userDefaults.set(data, forKey: name)
    }
    
    func userData(name:String) -> Any?{
        return userDefaults.object(forKey: name)
    }
    
}
