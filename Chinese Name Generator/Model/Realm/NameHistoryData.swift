//
//  NameHistoryData.swift
//  Chinese Name Generator
//
//  Created by 舅 on 2020/4/13.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation
import RealmSwift

class NameHistoryData : Object {
    @objc dynamic var create_time : String = ""
    @objc dynamic var status : String = ""
    @objc dynamic var message : String = ""
    let surnames = List<HistorySurnames>()
    let names = List<HistoryNames>()
    let chars = List<HistoryChars>()
}

class HistorySurnames : Object {
    @objc dynamic var surname : String = ""
    var parentData = LinkingObjects(fromType: NameHistoryData.self, property: "surnames")
}

class HistoryNames : Object {
    @objc dynamic var traditional : String = ""
    @objc dynamic var simplified : String = ""
    @objc dynamic var num_stroke : String = ""
    @objc dynamic var goodness : String = ""
    var parentData = LinkingObjects(fromType: NameHistoryData.self, property: "names")
}

class HistoryChars : Object {
    @objc dynamic var traditional : String = ""
    @objc dynamic var simplified : String = ""
    @objc dynamic var chinese : String = ""
    @objc dynamic var english : String = ""
    @objc dynamic var pinyin : String = ""
    @objc dynamic var phonetic : String = ""
    @objc dynamic var stroke : String = ""
    @objc dynamic var radical : String = ""
    var parentData = LinkingObjects(fromType: NameHistoryData.self, property: "chars")
}
