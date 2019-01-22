//
//  Ship.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/13/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import Unbox

class Ship: Unboxable {
    var engine:         Engine?
    var torpedo_bomber: TorpedoBomber?
    var anti_aircraft:  AntiAircraft?
    var mobility:       Mobility?
    var hull:           Hull?
    var atbas:          Atbas?
    var artillery:      Artillery?
    var torpedoes:      [Int] = []
    var fighters:       Fighters?
    var fire_control:   FireControl?
    var weaponry:       Weaponry?
    var battle_level_range_max: Int = 0
    var battle_level_range_min: Int = 0
    var flight_control: FlightControl?
    var concealment:    Concealment?
    var armour:         Armour?
    var dive_bomber:    DiveBomber?
    
    required init(unboxer: Unboxer) throws {
        engine =        try? unboxer.unbox(key: ShipInfoKeyInDB.engine.rawValue)
        torpedo_bomber = try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_bomber.rawValue)
        anti_aircraft = try? unboxer.unbox(key: ShipInfoKeyInDB.anti_aircraft.rawValue)
        mobility =      try? unboxer.unbox(key: ShipInfoKeyInDB.mobility.rawValue)
        hull =          try? unboxer.unbox(key: ShipInfoKeyInDB.hull.rawValue)
        atbas =         try? unboxer.unbox(key: ShipInfoKeyInDB.atbas.rawValue)
        artillery =     try? unboxer.unbox(key: ShipInfoKeyInDB.artillery.rawValue)
        torpedoes =     (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedoes.rawValue)) ?? []
        fighters =      try? unboxer.unbox(key: ShipInfoKeyInDB.fighter.rawValue)
        fire_control =  try? unboxer.unbox(key: ShipInfoKeyInDB.fire_control.rawValue)
        weaponry =      try? unboxer.unbox(key: ShipInfoKeyInDB.weaponry.rawValue)
        battle_level_range_max = (try? unboxer.unbox(key: ShipInfoKeyInDB.battle_level_range_max.rawValue)) ?? 0
        battle_level_range_min = (try? unboxer.unbox(key: ShipInfoKeyInDB.battle_level_range_min.rawValue)) ?? 0
        flight_control = try? unboxer.unbox(key: ShipInfoKeyInDB.flight_control.rawValue)
        concealment =   try? unboxer.unbox(key: ShipInfoKeyInDB.concealment.rawValue)
        armour =        try? unboxer.unbox(key: ShipInfoKeyInDB.armour.rawValue)
        dive_bomber =   try? unboxer.unbox(key: ShipInfoKeyInDB.dive_bomber.rawValue)
    }
}

struct Engine: Unboxable {
    let engine_id: Int
    let engine_id_str: String
    let max_speed: Float
    
    init(unboxer: Unboxer) throws {
        engine_id = (try? unboxer.unbox(key: ShipInfoKeyInDB.engine_id.rawValue)) ?? 0
        engine_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.engine_id_str.rawValue)) ?? ""
        max_speed = (try? unboxer.unbox(key: ShipInfoKeyInDB.max_speed.rawValue)) ?? 0
    }
}

struct Hull: Unboxable {
    let hull_id: Int
    let hull_id_str: String
    let torpedoes_barrels: Int
    let anti_aircraft_barrels: Int
    let range: Range
    let health: Int
    let planes_amount: Int
    let artillery_barrels: Int
    let atba_barrels: Int
    
    init(unboxer: Unboxer) throws {
        hull_id
        hull_id_str
        torpedoes_barrels
        anti_aircraft_barrels
        range
        health
        planes_amount
        artillery_barrels
        atba_barrels
    }
}

struct Mobility: Unboxable {
    let rudder_time: Float
    let total: Float
    let turning_radius: Float
    let max_speed: Float
    
    init(unboxer: Unboxer) throws {
        rudder_time
        total
        turning_radius
        max_speed
    }
}

struct Atbas: Unboxable {
    let distance: Int
    let slots: [String: AtbasSlotModel]
    
    init(unboxer: Unboxer) throws {
        distance
        slots
    }
}

struct AtbasSlotModel: Unboxable {
    let burn_probability: Float
    let bullet_speed: Int
    let name: String
    let shot_delay: Float
    let damage: Int
    let bullet_mass: Int
    let type: String // "HE", "AP"
    let gun_rate: Float
    
    init(unboxer: Unboxer) throws {
        burn_probability
        bullet_speed
        name
        shot_delay
        damage
        bullet_mass
        type
        gun_rate
    }
}

struct Artillery: Unboxable {
    let max_dispersion: Int
    let shells: [String: Shell] // ["HE": Shell, "AP": Shell]
    let shot_delay: Float
    let rotation_time: Float
    let distance: Float
    let artillery_id: Int
    let artillery_id_str: String
    let slots: [String: ArtillerySlot] // "0": slot, "1": slot, ...
    let gun_rate: Int
}

struct Shell: Unboxable {
    let burn_probability: Float
    let bullet_speed: Int
    let name: String
    let damage: Int
    let bullet_mass: Int
    let type: String //"AP"
}

struct ArtillerySlot: Unboxable {
    let barrels: Int
    let name: String
    let guns: Int
}

struct FireControl: Unboxable {
    let fire_control_id: Int
    let fire_control_id_str: String
    let distance: Float
    let distance_increase: Float
}

struct Weaponry: Unboxable {
    let anti_aircraft: Int
    let aircraft: Int
    let artillery: Int
    let torpedoes: Int
}

struct Concealment: Unboxable {
    let total: Int
    let detect_distance_by_plane: Float
    let detect_distance_by_ship: Float
}

struct Armour: Unboxable {
    let casemate: Range
    let flood_prob: Float
    let deck: Range
    let flood_damage: Int
    let range: Range
    let health: Int
    let extremities: Range
    let total: Int
    let citadel: Range
}


struct AntiAircraft: Unboxable {
    let slots: [String: AntiAircraftSlot]
    let defense: Float
    
}

struct AntiAircraftSlot: Unboxable {
    let distance: Float
    let avg_damage: Float
    let caliber: Float
    let name: String
    let guns: Int
}
