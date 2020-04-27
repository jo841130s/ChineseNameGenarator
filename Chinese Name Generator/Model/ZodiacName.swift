//
//  ZodiacName.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/24.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

class ZodiacName {
    
    var isForeigner : Bool = true
    
    var imageName = "Rat"
    
    var rat : String {
        imageName = "Rat"
        if isForeigner {
            return "Rat"
        } else {
            return "鼠"
        }
    }
    
    var ox : String {
        imageName = "Ox"
        if isForeigner {
            return "Ox"
        } else {
            return "牛"
        }
    }
    
    var tiger : String {
        imageName = "Tiger"
        if isForeigner {
            return "Tiger"
        } else {
            return "虎"
        }
    }
    
    var rabbit : String {
        imageName = "Rabbit"
        if isForeigner {
            return "Rabbit"
        } else {
            return "兔"
        }
    }
    
    var dragon : String {
        imageName = "Dragon"
        if isForeigner {
            return "Dragon"
        } else {
            return "龍"
        }
    }
    
    var snake : String {
        imageName = "Snake"
        if isForeigner {
            return "Snake"
        } else {
            return "蛇"
        }
    }
    
    var horse : String {
        imageName = "Horse"
        if isForeigner {
            return "Horse"
        } else {
            return "馬"
        }
    }
    
    var goat : String {
        imageName = "Goat"
        if isForeigner {
            return "Goat"
        } else {
            return "羊"
        }
    }
    
    var monkey : String {
        imageName = "Monkey"
        if isForeigner {
            return "Monkey"
        } else {
            return "猴"
        }
    }
    
    var rooster : String {
        imageName = "Rooster"
        if isForeigner {
            return "Rooster"
        } else {
            return "雞"
        }
    }
    
    var dog : String {
        imageName = "Dog"
        if isForeigner {
            return "Dog"
        } else {
            return "狗"
        }
    }
    
    var pig : String {
        imageName = "Pig"
        if isForeigner {
            return "Pig"
        } else {
            return "豬"
        }
    }
    
    
}
