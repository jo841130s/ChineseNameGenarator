//
//  HoroscopeName.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/24.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

class HoroscopeName {
    
    var isForeigner : Bool = true
    
    var imageName = "Capricorn"
    
    var aquarius : String {
        imageName = "Aquarius"
        if isForeigner {
            return "Aquarius"
        } else {
            return "水瓶"
        }
    }
    
    var pisces : String {
        imageName = "Pisces"
        if isForeigner {
            return "Pisces"
        } else {
            return "雙魚"
        }
    }
    
    var aries : String {
        imageName = "Aries"
        if isForeigner {
            return "Aries"
        } else {
            return "牡羊"
        }
    }
    
    var taurus : String {
        imageName = "Taurus"
        if isForeigner {
            return "Taurus"
        } else {
            return "金牛"
        }
    }
    
    var gemini : String {
        imageName = "Gemini"
        if isForeigner {
            return "Gemini"
        } else {
            return "雙子"
        }
    }
    
    var cancer : String {
        imageName = "Cancer"
        if isForeigner {
            return "Cancer"
        } else {
            return "巨蟹"
        }
    }
    
    var leo : String {
        imageName = "Leo"
        if isForeigner {
            return "Leo"
        } else {
            return "獅子"
        }
    }
    
    var virgo : String {
        imageName = "Virgo"
        if isForeigner {
            return "Virgo"
        } else {
            return "處女"
        }
    }
    
    var libra : String {
        imageName = "Libra"
        if isForeigner {
            return "Libra"
        } else {
            return "天秤"
        }
    }
    
    var scorpio : String {
        imageName = "Scorpio"
        if isForeigner {
            return "Scorpio"
        } else {
            return "天蠍"
        }
    }
    
    var sagittarius : String {
        imageName = "Sagittarius"
        if isForeigner {
            return "Sagittarius"
        } else {
            return "射手"
        }
    }
    
    var capricorn : String {
        imageName = "Capricorn"
        if isForeigner {
            return "Capricorn"
        } else {
            return "摩羯"
        }
    }
    
    
}
