//
//  DBKeys.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/22/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

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
    
    case min = "min"
    case max = "max"
    
    // ShipModule
    case engine = "engine"
    case torpedo_bomber = "torpedo_bomber"
    case fighter = "fighter"
    case hull = "hull"
    case artillery = "artillery"
    case torpedoes = "torpedoes"
    case fire_control = "fire_control"
    case flight_control = "flight_control"
    case dive_bomber = "dive_bomber"
    
    // Ship Module Tree Node
    case next_modules = "next_modules"
    case is_default = "is_default"
    case price_xp = "price_xp"
    case module_id = "module_id"
    case module_id_str = "module_id_str"
    
    // Ship
    case anti_aircraft = "anti_aircraft"
    case mobility = "mobility"
    case atbas = "atbas"
    case fighters = "fighters"
    case weaponry = "weaponry"
    case battle_level_range_max = "battle_level_range_max"
    case battle_level_range_min = "battle_level_range_min"
    case concealment = "concealment"
    case armour = "armour"
    
    // Engine
    case engine_id = "engine_id"
    case engine_id_str = "engine_id_str"
    case max_speed = "max_speed"
    
}
