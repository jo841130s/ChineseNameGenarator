//
//  UserData.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/3/28.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

class UserData {
    
    static var isForeigner : Bool = false
    
    static func setUserData(data:Any,name:String) {
        UserDefaults.standard.set(data, forKey: name)
    }
    
    static func userData(name:String) -> Any?{
        return UserDefaults.standard.object(forKey: name)
    }
    
}
