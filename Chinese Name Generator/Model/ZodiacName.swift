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
    
    var info = ""
    
    var rat : String {
        imageName = "Rat"
        info = "Quick-witted, resourceful, versatile, kind"
        if isForeigner {
            return "Rat"
        } else {
            return "鼠"
        }
    }
    
    var ox : String {
        imageName = "Ox"
        info = "Diligent, dependable, strong, determined"
        if isForeigner {
            return "Ox"
        } else {
            return "牛"
        }
    }
    
    var tiger : String {
        imageName = "Tiger"
        info = "Brave, confident, competitive"
        if isForeigner {
            return "Tiger"
        } else {
            return "虎"
        }
    }
    
    var rabbit : String {
        imageName = "Rabbit"
        info = "Quiet, elegant, kind, responsible"
        if isForeigner {
            return "Rabbit"
        } else {
            return "兔"
        }
    }
    
    var dragon : String {
        imageName = "Dragon"
        info = "Confident, intelligent, enthusiastic"
        if isForeigner {
            return "Dragon"
        } else {
            return "龍"
        }
    }
    
    var snake : String {
        imageName = "Snake"
        info = "Enigmatic, intelligent, wise"
        if isForeigner {
            return "Snake"
        } else {
            return "蛇"
        }
    }
    
    var horse : String {
        imageName = "Horse"
        info = "Animated, active, energetic"
        if isForeigner {
            return "Horse"
        } else {
            return "馬"
        }
    }
    
    var goat : String {
        imageName = "Goat"
        info = "Calm, gentle, sympathetic"
        if isForeigner {
            return "Goat"
        } else {
            return "羊"
        }
    }
    
    var monkey : String {
        imageName = "Monkey"
        info = "Sharp, smart, curiosity"
        if isForeigner {
            return "Monkey"
        } else {
            return "猴"
        }
    }
    
    var rooster : String {
        imageName = "Rooster"
        info = "Observant, hardworking, courageous"
        if isForeigner {
            return "Rooster"
        } else {
            return "雞"
        }
    }
    
    var dog : String {
        imageName = "Dog"
        info = "Lovely, honest, prudent"
        if isForeigner {
            return "Dog"
        } else {
            return "狗"
        }
    }
    
    var pig : String {
        imageName = "Pig"
        info = "Compassionate, generous, diligent"
        if isForeigner {
            return "Pig"
        } else {
            return "豬"
        }
    }
    
    
}
