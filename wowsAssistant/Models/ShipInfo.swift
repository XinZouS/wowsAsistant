//
//  ShipInfo.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/18/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

struct Range {
    let min: Int
    let max: Int
}

struct ShipInfo {
    let description:    String
    let price_gold:     Int
    let ship_id:        Int
    let ship_id_str:    String
    let has_demo_profile: Bool
    let images:     [String:String] // keys: "small", "medium", "large", "contour"
    let modules:    ShipModule
    let modules_tree: [String: ShipModuleTreeNode]
    let nation:     String
    let is_premium: Bool
    let price_credit: Int
    let default_profile: Ship
    let upgrades:   [Int]
    let tier:       Int
    let next_ships: String
    let mod_slots:  Int
    let type:       String
    let is_special: Bool
    let name:       String
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


