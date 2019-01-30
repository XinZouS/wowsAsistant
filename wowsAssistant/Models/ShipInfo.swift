//
//  ShipInfo.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/18/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import Unbox


struct Range: Unboxable {
    let min: Int
    let max: Int
    
    init() {
        min = 0
        max = 0
    }
    
    init(unboxer: Unboxer) throws {
        min = (try? unboxer.unbox(key: ShipInfoKeyInDB.min.rawValue)) ?? 0
        max = (try? unboxer.unbox(key: ShipInfoKeyInDB.max.rawValue)) ?? 0
    }
}


class ShipInfo: Unboxable {
    var description:    String?
    var ship_id:        Int = 0 // Int32, max = 42940 00000
    var ship_id_str:    String = ""
    var has_demo_profile: Bool?
    var images:     [String:String]? // keys: "small", "medium", "large", "contour"
    var modules:    ShipModule?
    var modules_tree: [String: ShipModuleTreeNode]? // [id: moduleNode]
    var nation:     String?
    var is_premium: Bool?
    var price_credit: Int?
    var price_gold:   Int?
    var default_profile: Ship?
    var upgrades:   [Int]?
    var tier:       Int?
    var next_ships: [Int]?
    var mod_slots:  Int?
    var type:       String?
    var is_special: Bool?
    var name:       String?
    
    var imagesStruct: ShipInfoImages?
    var typeEnum = ShipType.AC
    var nationEnum = ShipNation.usa
    
    required init(unboxer: Unboxer) {
        self.description = (try? unboxer.unbox(key: ShipInfoKeyInDB.description.rawValue))
        self.ship_id =     (try? unboxer.unbox(key: ShipInfoKeyInDB.ship_id.rawValue)) ?? 0
        self.ship_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.ship_id_str.rawValue)) ?? "0"
        self.has_demo_profile = try? unboxer.unbox(key: ShipInfoKeyInDB.has_demo_profile.rawValue)
        self.images =       try? unboxer.unbox(key: ShipInfoKeyInDB.images.rawValue)
        self.modules =      try? unboxer.unbox(key: ShipInfoKeyInDB.modules.rawValue)
        self.modules_tree = try? unboxer.unbox(key: ShipInfoKeyInDB.modules_tree.rawValue)
        self.nation =       try? unboxer.unbox(key: ShipInfoKeyInDB.nation.rawValue)
        self.is_premium =   try? unboxer.unbox(key: ShipInfoKeyInDB.is_premium.rawValue)
        self.price_credit = try? unboxer.unbox(key: ShipInfoKeyInDB.price_credit.rawValue)
        self.price_gold =   try? unboxer.unbox(key: ShipInfoKeyInDB.price_gold.rawValue)
        self.default_profile = try? unboxer.unbox(key: ShipInfoKeyInDB.default_profile.rawValue)
        self.upgrades =     try? unboxer.unbox(key: ShipInfoKeyInDB.upgrades.rawValue)
        self.tier =         try? unboxer.unbox(key: ShipInfoKeyInDB.tier.rawValue)
        self.next_ships =   try? unboxer.unbox(key: ShipInfoKeyInDB.next_ships.rawValue)
        self.mod_slots =    try? unboxer.unbox(key: ShipInfoKeyInDB.mod_slots.rawValue)
        self.type =         try? unboxer.unbox(key: ShipInfoKeyInDB.type.rawValue)
        self.is_special =   try? unboxer.unbox(key: ShipInfoKeyInDB.is_special.rawValue)
        self.name =         try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)
        
        if let imgs = images {
            self.imagesStruct = ShipInfoImages(imgs)
        }
        if let str = type {
            switch str {
            case ShipType.AC.rawValue:
                self.typeEnum = .AC
            case ShipType.BB.rawValue:
                self.typeEnum = .BB
            case ShipType.CR.rawValue:
                self.typeEnum = .CR
            case ShipType.DD.rawValue:
                self.typeEnum = .DD
            case ShipType.SB.rawValue:
                self.typeEnum = .SB
            default:
                self.typeEnum = .AC
            }
        }
        if let nationStr = nation, let n = ShipNation(rawValue: nationStr) {
            self.nationEnum = n
        }
    }
}

extension ShipInfo: Comparable {
    
    /// use: myArray.sorted()
    static func == (a: ShipInfo, b: ShipInfo) -> Bool {
        return a.typeEnum.tagInt() == b.typeEnum.tagInt() &&
            a.nationEnum.tagInt() == b.nationEnum.tagInt() &&
            (a.tier ?? 0) == (b.tier ?? 0)
    }
    
    /// use: myArray.sorted()
    static func < (a: ShipInfo, b: ShipInfo) -> Bool {
        if a.typeEnum.tagInt() == b.typeEnum.tagInt() {
            if a.tier == b.tier {
                return a.nationEnum.tagInt() < b.nationEnum.tagInt()
            }
            return (a.tier ?? 0) > (b.tier ?? 0) // X, IX, VIII, ...
        }
        return a.typeEnum.tagInt() < b.typeEnum.tagInt()
    }
}

struct ShipInfoImages {
    let small: String
    let medium: String
    let large: String
    let contour: String
    
    init(_ dictionary: [String:String]) {
        small = dictionary[ShipInfoKeyInDB.small.rawValue] ?? ""
        medium = dictionary[ShipInfoKeyInDB.medium.rawValue] ?? ""
        large = dictionary[ShipInfoKeyInDB.large.rawValue] ?? ""
        contour = dictionary[ShipInfoKeyInDB.contour.rawValue] ?? ""
    }
}


class ShipModule: Unboxable {
    var engine:         [Int]?
    var torpedo_bomber: [Int]?
    var fighter:        [Int]?
    var hull:           [Int]?
    var artillery:      [Int]?
    var torpedoes:      [Int]?
    var fire_control:   [Int]?
    var flight_control: [Int]?
    var dive_bomber:    [Int]?
    
    required init(unboxer: Unboxer) throws {
        engine =        try? unboxer.unbox(key: ShipInfoKeyInDB.engine.rawValue)
        torpedo_bomber = try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_bomber.rawValue)
        fighter =       try? unboxer.unbox(key: ShipInfoKeyInDB.fighter.rawValue)
        hull =          try? unboxer.unbox(key: ShipInfoKeyInDB.hull.rawValue)
        artillery =     try? unboxer.unbox(key: ShipInfoKeyInDB.artillery.rawValue)
        torpedoes =     try? unboxer.unbox(key: ShipInfoKeyInDB.torpedoes.rawValue)
        fire_control =  try? unboxer.unbox(key: ShipInfoKeyInDB.fire_control.rawValue)
        flight_control = try? unboxer.unbox(key: ShipInfoKeyInDB.flight_control.rawValue)
        dive_bomber =   try? unboxer.unbox(key: ShipInfoKeyInDB.dive_bomber.rawValue)
    }
}

class ShipModuleTreeNode: Unboxable {
    var module_id: Int = 0
    var module_id_str: String = "0"
    var name: String = ""
    var next_modules: String?
    var is_default: Bool?
    var price_xp: Int?
    var price_credit: Int?
    var next_ships: String?
    var type: String?
    
    required init(unboxer: Unboxer) throws {
        module_id =     (try? unboxer.unbox(key: ShipInfoKeyInDB.module_id.rawValue)) ?? 0
        module_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.module_id_str.rawValue)) ?? "0"
        name =          (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
        next_modules =  try? unboxer.unbox(key: ShipInfoKeyInDB.next_modules.rawValue)
        is_default =    try? unboxer.unbox(key: ShipInfoKeyInDB.is_default.rawValue)
        price_xp =      try? unboxer.unbox(key: ShipInfoKeyInDB.price_xp.rawValue)
        price_credit =  try? unboxer.unbox(key: ShipInfoKeyInDB.price_credit.rawValue)
        next_ships =    try? unboxer.unbox(key: ShipInfoKeyInDB.next_ships.rawValue)
        type =          try? unboxer.unbox(key: ShipInfoKeyInDB.type.rawValue)
    }
}


