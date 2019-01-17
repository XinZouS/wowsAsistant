//
//  Ship.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/13/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

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
    let type:       ShipType
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


struct Ship {
    let engine: Engine
    let torpedo_bomber: TorpedoBomber
    let anti_aircraft: {
    -"slots": {
    -"0": {
    "distance": 3.5,
    "avg_damage": 140,
    "caliber": 40,
    "name": "40 毫米 博福斯 Mk V RP50",
    "guns": 6
    },
    -"1": {
    "distance": 5,
    "avg_damage": 71,
    "caliber": 102,
    "name": "102 毫米/45 QF RP51 Mk XVIV*",
    "guns": 4
    }
    },
    "defense": 55
    },
    -"mobility": {
    "rudder_time": 9.6,
    "total": 62,
    "turning_radius": 680,
    "max_speed": 32.5
    },
    -"hull": {
    "hull_id": 3654037456,
    "hull_id_str": "PBUH611",
    "torpedoes_barrels": 0,
    "anti_aircraft_barrels": 10,
    -"range": {
    "max": 114,
    "min": 6
    },
    "health": 35700,
    "planes_amount": 0,
    "artillery_barrels": 4,
    "atba_barrels": 4
    },
    -"atbas": {
    "distance": 5,
    -"slots": {
    -"0": {
    "burn_probability": 6,
    "bullet_speed": 811,
    "name": "102 毫米 HE 35 lb",
    "shot_delay": 3,
    "damage": 1500,
    "bullet_mass": 16,
    "type": "HE",
    "gun_rate": 20
    }
    }
    },
    -"artillery": {
    "max_dispersion": 139,
    -"shells": {
    -"AP": {
    "burn_probability": null,
    "bullet_speed": 841,
    "name": "152 毫米 AP 6crh Mk IV",
    "damage": 3100,
    "bullet_mass": 51,
    "type": "AP"
    },
    -"HE": {
    "burn_probability": 9,
    "bullet_speed": 841,
    "name": "152 毫米 HE 6crh Mk IV",
    "damage": 2100,
    "bullet_mass": 51,
    "type": "HE"
    }
    },
    "shot_delay": 7,
    "rotation_time": 25.71,
    "distance": 15.4,
    "artillery_id": 3654266832,
    "artillery_id_str": "PBUA611",
    -"slots": {
    -"0": {
    "barrels": 3,
    "name": "152 毫米/50 Mk XXIII",
    "guns": 4
    }
    },
    "gun_rate": 8
    },
    "torpedoes": null,
    "fighters": null,
    -"fire_control": {
    "fire_control_id": 3653677008,
    "distance": 15.4,
    "distance_increase": 0,
    "fire_control_id_str": "PBUS611"
    },
    -"weaponry": {
    "anti_aircraft": 55,
    "aircraft": 0,
    "artillery": 50,
    "torpedoes": 0
    },
    "battle_level_range_max": 9,
    "battle_level_range_min": 7,
    "flight_control": null,
    -"concealment": {
    "total": 59,
    "detect_distance_by_plane": 8.1,
    "detect_distance_by_ship": 11.3
    },
    -"armour": {
    -"casemate": {
    "max": -1,
    "min": -1
    },
    "flood_prob": 4,
    -"deck": {
    "max": -1,
    "min": -1
    },
    "flood_damage": 67,
    -"range": {
    "max": 114,
    "min": 6
    },
    "health": 35700,
    -"extremities": {
    "max": -1,
    "min": -1
    },
    "total": 47,
    -"citadel": {
    "max": -1,
    "min": -1
    }
    },
    "dive_bomber": null
}

struct Engine {
    let engine_id: Int
    let engine_id_str: String
    let max_speed: Float
}
