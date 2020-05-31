//
//  HoroscopeName.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/24.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

class HoroscopeName {
    
    var isForeigner : Bool = UserDefaults.standard.bool(forKey: "isForeigner")
    
    var imageName = "Capricorn"
    
    var info = ""
    
    var aquarius : String {
        imageName = "Aquarius"
        info = "與眾不同、獨立、冷靜、好奇心強、聰明"
        if isForeigner {
            return "Aquarius"
        } else {
            return "水瓶"
        }
    }
    
    var pisces : String {
        imageName = "Pisces"
        info = "想像力強、具有同情心、藝術特質、浪漫多情"
        if isForeigner {
            return "Pisces"
        } else {
            return "雙魚"
        }
    }
    
    var aries : String {
        imageName = "Aries"
        info = "勇氣、熱情活躍、好奇心強、具領導力、動作快"
        if isForeigner {
            return "Aries"
        } else {
            return "牡羊"
        }
    }
    
    var taurus : String {
        imageName = "Taurus"
        info = "切合實際、確定務實、誠信有決心感官力強"
        if isForeigner {
            return "Taurus"
        } else {
            return "金牛"
        }
    }
    
    var gemini : String {
        imageName = "Gemini"
        info = "聰明、擅溝通、博學、好奇心強、學習力強"
        if isForeigner {
            return "Gemini"
        } else {
            return "雙子"
        }
    }
    
    var cancer : String {
        imageName = "Cancer"
        info = "感性、保護家人、收藏家、敏感、同情心"
        if isForeigner {
            return "Cancer"
        } else {
            return "巨蟹"
        }
    }
    
    var leo : String {
        imageName = "Leo"
        info = "自信、創造、領導、表演、熱心助人"
        if isForeigner {
            return "Leo"
        } else {
            return "獅子"
        }
    }
    
    var virgo : String {
        imageName = "Virgo"
        info = "、謹慎、穩定、負責、擅思考、注重養生"
        if isForeigner {
            return "Virgo"
        } else {
            return "處女"
        }
    }
    
    var libra : String {
        imageName = "Libra"
        info = "機智、公平、優雅、魅力、美感"
        if isForeigner {
            return "Libra"
        } else {
            return "天秤"
        }
    }
    
    var scorpio : String {
        imageName = "Scorpio"
        info = "持續力強、權威、迎接挑戰、愛恨分明、敏感"
        if isForeigner {
            return "Scorpio"
        } else {
            return "天蠍"
        }
    }
    
    var sagittarius : String {
        imageName = "Sagittarius"
        info = "大膽冒險、上進好學、樂觀、幽默風趣、好奇心強"
        if isForeigner {
            return "Sagittarius"
        } else {
            return "射手"
        }
    }
    
    var capricorn : String {
        imageName = "Capricorn"
        info = "領導、傳統、穩重、目標遠大、堅持理想"
        if isForeigner {
            return "Capricorn"
        } else {
            return "摩羯"
        }
    }
    
    
}
