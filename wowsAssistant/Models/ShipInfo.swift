//
//  ShipInfo.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/18/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import Unbox


struct Range {
    let min: Int
    let max: Int
}


enum ShipInfoKeyInDB: String {
    case description = "description"
    case ship_id = "ship_id"
    case ship_id_str = "ship_id_str"
    case has_demo_profile = "has_demo_profile"
    case images = "images"
    case modules = "modules"
    case modules_tree = "modules_tree"
    case nation = "nation"
    case is_premium = "is_premium"
    case price_credit = "price_credit"
    case price_gold = "price_gold"
    case default_profile = "default_profile"
    case upgrades = "upgrades"
    case tier = "tier"
    case next_ships = "next_ships"
    case mod_slots = "mod_slots"
    case type = "type"
    case is_special = "is_special"
    case name = "name"

}

class ShipInfo: Unboxable {
    var description:    String?
    var ship_id:        Int = 0
    var ship_id_str:    String?
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
    var next_ships: String?
    var mod_slots:  Int?
    var type:       String?
    var is_special: Bool?
    var name:       String?
    
    required init(unboxer: Unboxer) {
        self.description =  (try? unboxer.unbox(key: ShipInfoKeyInDB.description.rawValue))
        self.ship_id =      (try? unboxer.unbox(key: ShipInfoKeyInDB.ship_id.rawValue)) ?? 0
        self.ship_id_str =  try? unboxer.unbox(key: ShipInfoKeyInDB.ship_id_str.rawValue)
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
    }
}


struct ShipModule {
    let engine:         [Int]
    let torpedo_bomber: [Int]
    let fighter:        [Int]
    let hull:           [Int]
    let artillery:      [Int]
    let torpedoes:      [Int]
    let fire_control:   [Int]
    let flight_control: [Int]
    let dive_bomber:    [Int]
}

struct ShipModuleTreeNode {
    let name: String
    let next_modules: String
    let is_default: Bool
    let price_xp: Int
    let price_credit: Int
    let next_ships: String
    let module_id: String
    let type: String
    let module_id_str: String
}


