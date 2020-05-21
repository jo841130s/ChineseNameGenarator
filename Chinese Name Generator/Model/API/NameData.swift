//
//  NamesData.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/5.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

struct NameData : Codable {
    var create_time : String
    var status : String
    var message : String
    var surnames : [String]?
    var names : [Names]
    var chars : [Chars]
}

struct CNNameData : Codable {
    var create_time : String
    var status : String
    var message : String
    var names : [Names]
    var chars : [Chars]
}

struct Names : Codable {
    var traditional : String
    var simplified : String
    var num_stroke : String
    var goodness : String
}

struct Chars : Codable {
    var traditional : String
    var simplified : String
    var chinese : String
    var english : String
    var pinyin : String
    var phonetic : String
    var stroke : String
    var radical : String
}
