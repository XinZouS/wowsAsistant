//
//  DBKeys.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/22/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

enum ShipInfoKeyInDB: String {
    
    // Ship info
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
    
    // Image info
    case small = "small"
    case medium = "medium"
    case large = "large"
    case contour = "contour"
    
    // Range
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
    
    // Hull
    case hull_id = "hull_id"
    case hull_id_str = "hull_id_str"
    case torpedoes_barrels = "torpedoes_barrels"
    case anti_aircraft_barrels = "anti_aircraft_barrels"
    case range = "range"
    case health = "health"
    case planes_amount = "planes_amount"
    case artillery_barrels = "artillery_barrels"
    case atba_barrels = "atba_barrels"

    // Mobility
    case rudder_time = "rudder_time"
    case total = "total"
    case turning_radius = "turning_radius"
    
    // Atbas
    case distance = "distance"
    case slots = "slots"
    
    // AtbasSlotModule
    case burn_probability = "burn_probability"
    case bullet_speed = "bullet_speed"
    case shot_delay = "shot_delay"
    case damage = "damage"
    case bullet_mass = "bullet_mass"
    case gun_rate = "gun_rate"
    
    // Artillery
    case max_dispersion = "max_dispersion"
    case shells = "shells"
    case rotation_time = "rotation_time"
    case artillery_id = "artillery_id"
    case artillery_id_str = "artillery_id_str"
    
    // Artillery slot
    case barrels = "barrels"
    case guns = "guns"
    
    // Fire control
    case fire_control_id = "fire_control_id"
    case fire_control_id_str = "fire_control_id_str"
    case distance_increase = "distance_increase"
    
    // Weaponary
    case aircraft = "aircraft"
    
    // Concealment
    case detect_distance_by_plane = "detect_distance_by_plane"
    case detect_distance_by_ship = "detect_distance_by_ship"
    
    // Armour
    case casemate = "casemate"
    case flood_prob = "flood_prob"
    case deck = "deck"
    case flood_damage = "flood_damage"
    case extremities = "extremities"
    case citadel = "citadel"
    
    // Torpedoes
    case visibility_dist = "visibility_dist"
    case torpedoes_id = "torpedoes_id"
    case torpedoes_id_str = "torpedoes_id_str"
    case reload_time = "reload_time"
    case torpedo_speed = "torpedo_speed"
    
    // AntiAircraft
    case defense = "defense"
    
    // AntiAircraft slot
    case avg_damage = "avg_damage"
    case caliber = "caliber"
    
    // Flight control
    case flight_control_id = "flight_control_id"
    case flight_control_id_str = "flight_control_id_str"
    case bomber_squadrons = "bomber_squadrons"
    case torpedo_squadrons = "torpedo_squadrons"
    case fighter_squadrons = "fighter_squadrons"

    // Airplane
    case squadrons = "squadrons"
    case count_in_squadron = "count_in_squadron"
    case cruise_speed = ""
    case prepare_time = "prepare_time"
    case gunner_damage = "gunner_damage"
    case plane_level = "plane_level"
    case max_health = "max_health"
    
    // Fighters
    case fighters_id = "fighters_id"
    case fighters_id_str = "fighters_id_str"
    case max_ammo = "max_ammo"
    
    // TorpedoBomber
    case torpedo_bomber_id = "torpedo_bomber_id"
    case torpedo_bomber_id_str = "torpedo_bomber_id_str"
    case torpedo_distance =  "torpedo_distance"
    case torpedo_damage = "torpedo_damage"
    case torpedo_max_speed = "torpedo_max_speed"
    case torpedo_name = "torpedo_name"
    case max_damage = "max_damage"
    
    // DiveBomber
    case dive_bomber_id = "dive_bomber_id"
    case dive_bomber_id_str = "dive_bomber_id_str"
    case bomb_damage = "bomb_damage"
    case bomb_name = "bomb_name"
    case bomb_bullet_mass = "bomb_bullet_mass"
    case bomb_burn_probability = "bomb_burn_probability"
    case accuracy = "accuracy"
    
    // Consumables
    case consumableId = "consumable_id"
    case profile = "profile"
    case image = "image"
    case value = "value"
    
    // Commander skills
    case typeId = "type_id"
    case typeName = "type_name"
    case perks = "perks"
    case icon = "icon"
}
