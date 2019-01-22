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
        hull_id = (try? unboxer.unbox(key: ShipInfoKeyInDB.hull_id.rawValue)) ?? 0
        hull_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.hull_id_str.rawValue)) ?? ""
        torpedoes_barrels = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedoes_barrels.rawValue)) ?? 0
        anti_aircraft_barrels = (try? unboxer.unbox(key: ShipInfoKeyInDB.anti_aircraft_barrels.rawValue)) ?? 0
        range = (try? unboxer.unbox(key: ShipInfoKeyInDB.range.rawValue)) ?? Range()
        health = (try? unboxer.unbox(key: ShipInfoKeyInDB.health.rawValue)) ?? 0
        planes_amount = (try? unboxer.unbox(key: ShipInfoKeyInDB.planes_amount.rawValue)) ?? 0
        artillery_barrels = (try? unboxer.unbox(key: ShipInfoKeyInDB.artillery_barrels.rawValue)) ?? 0
        atba_barrels = (try? unboxer.unbox(key: ShipInfoKeyInDB.atba_barrels.rawValue)) ?? 0
    }
}

struct Mobility: Unboxable {
    let rudder_time: Float
    let total: Float
    let turning_radius: Float
    let max_speed: Float
    
    init(unboxer: Unboxer) throws {
        rudder_time = (try? unboxer.unbox(key: ShipInfoKeyInDB.rudder_time.rawValue)) ?? 0
        total       = (try? unboxer.unbox(key: ShipInfoKeyInDB.total.rawValue)) ?? 0
        turning_radius = (try? unboxer.unbox(key: ShipInfoKeyInDB.turning_radius.rawValue)) ?? 0
        max_speed = (try? unboxer.unbox(key: ShipInfoKeyInDB.max_speed.rawValue)) ?? 0
    }
}

struct Atbas: Unboxable {
    let distance: Int
    let slots: [String: AtbasSlotModel]
    
    init(unboxer: Unboxer) throws {
        distance = (try? unboxer.unbox(key: ShipInfoKeyInDB.distance.rawValue)) ?? 0
        slots = (try? unboxer.unbox(key: ShipInfoKeyInDB.slots.rawValue)) ?? [:]
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
        burn_probability = (try? unboxer.unbox(key: ShipInfoKeyInDB.burn_probability.rawValue)) ?? 0
        bullet_speed = (try? unboxer.unbox(key: ShipInfoKeyInDB.bullet_speed.rawValue)) ?? 0
        name = (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
        shot_delay = (try? unboxer.unbox(key: ShipInfoKeyInDB.shot_delay.rawValue)) ?? 0
        damage = (try? unboxer.unbox(key: ShipInfoKeyInDB.damage.rawValue)) ?? 0
        bullet_mass = (try? unboxer.unbox(key: ShipInfoKeyInDB.bullet_mass.rawValue)) ?? 0
        type = (try? unboxer.unbox(key: ShipInfoKeyInDB.type.rawValue)) ?? ""
        gun_rate = (try? unboxer.unbox(key: ShipInfoKeyInDB.gun_rate.rawValue)) ?? 0
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
    
    init(unboxer: Unboxer) throws {
        max_dispersion = (try? unboxer.unbox(key: ShipInfoKeyInDB.max_dispersion.rawValue)) ?? 0
        shells = (try? unboxer.unbox(key: ShipInfoKeyInDB.shells.rawValue)) ?? [:]
        shot_delay = (try? unboxer.unbox(key: ShipInfoKeyInDB.shot_delay.rawValue)) ?? 0
        rotation_time = (try? unboxer.unbox(key: ShipInfoKeyInDB.rotation_time.rawValue)) ?? 0
        distance = (try? unboxer.unbox(key: ShipInfoKeyInDB.distance.rawValue)) ?? 0
        artillery_id = (try? unboxer.unbox(key: ShipInfoKeyInDB.artillery_id.rawValue)) ?? 0
        artillery_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.artillery_id_str.rawValue)) ?? ""
        slots = (try? unboxer.unbox(key: ShipInfoKeyInDB.slots.rawValue)) ?? [:]
        gun_rate = (try? unboxer.unbox(key: ShipInfoKeyInDB.gun_rate.rawValue)) ?? 0
    }
}

struct Shell: Unboxable {
    let burn_probability: Float
    let bullet_speed: Int
    let name: String
    let damage: Int
    let bullet_mass: Int
    let type: String //"AP"
    
    init(unboxer: Unboxer) throws {
        burn_probability = (try? unboxer.unbox(key: ShipInfoKeyInDB.burn_probability.rawValue)) ?? 0
        bullet_speed = (try? unboxer.unbox(key: ShipInfoKeyInDB.bullet_speed.rawValue)) ?? 0
        name = (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
        damage = (try? unboxer.unbox(key: ShipInfoKeyInDB.damage.rawValue)) ?? 0
        bullet_mass = (try? unboxer.unbox(key: ShipInfoKeyInDB.bullet_mass.rawValue)) ?? 0
        type = (try? unboxer.unbox(key: ShipInfoKeyInDB.type.rawValue)) ?? ""
    }
}

struct ArtillerySlot: Unboxable {
    let barrels: Int
    let name: String
    let guns: Int
    
    init(unboxer: Unboxer) throws {
        barrels = (try? unboxer.unbox(key: ShipInfoKeyInDB.barrels.rawValue)) ?? 0
        name = (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
        guns = (try? unboxer.unbox(key: ShipInfoKeyInDB.guns.rawValue)) ?? 0
    }
}

struct FireControl: Unboxable {
    let fire_control_id: Int
    let fire_control_id_str: String
    let distance: Float
    let distance_increase: Float
    
    init(unboxer: Unboxer) throws {
        fire_control_id = (try? unboxer.unbox(key: ShipInfoKeyInDB.fire_control_id.rawValue)) ?? 0
        fire_control_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.fire_control_id_str.rawValue)) ?? ""
        distance = (try? unboxer.unbox(key: ShipInfoKeyInDB.distance.rawValue)) ?? 0
        distance_increase = (try? unboxer.unbox(key: ShipInfoKeyInDB.distance_increase.rawValue)) ?? 0
    }
}

struct Weaponry: Unboxable {
    let anti_aircraft: Int
    let aircraft: Int
    let artillery: Int
    let torpedoes: Int
    
    init(unboxer: Unboxer) throws {
        anti_aircraft = (try? unboxer.unbox(key: ShipInfoKeyInDB.anti_aircraft.rawValue)) ?? 0
        aircraft = (try? unboxer.unbox(key: ShipInfoKeyInDB.aircraft.rawValue)) ?? 0
        artillery = (try? unboxer.unbox(key: ShipInfoKeyInDB.artillery.rawValue)) ?? 0
        torpedoes = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedoes.rawValue)) ?? 0
    }
}

struct Concealment: Unboxable {
    let total: Int
    let detect_distance_by_plane: Float
    let detect_distance_by_ship: Float
    
    init(unboxer: Unboxer) throws {
        total = (try? unboxer.unbox(key: ShipInfoKeyInDB.total.rawValue)) ?? 0
        detect_distance_by_plane = (try? unboxer.unbox(key: ShipInfoKeyInDB.detect_distance_by_plane.rawValue)) ?? 0
        detect_distance_by_ship = (try? unboxer.unbox(key: ShipInfoKeyInDB.detect_distance_by_ship.rawValue)) ?? 0
    }
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
    
    init(unboxer: Unboxer) throws {
        casemate =      (try? unboxer.unbox(key: ShipInfoKeyInDB.casemate.rawValue)) ?? Range()
        flood_prob =    (try? unboxer.unbox(key: ShipInfoKeyInDB.flood_prob.rawValue)) ?? 0
        deck =          (try? unboxer.unbox(key: ShipInfoKeyInDB.deck.rawValue)) ?? Range()
        flood_damage =  (try? unboxer.unbox(key: ShipInfoKeyInDB.flood_damage.rawValue)) ?? 0
        range =         (try? unboxer.unbox(key: ShipInfoKeyInDB.range.rawValue)) ?? Range()
        health =        (try? unboxer.unbox(key: ShipInfoKeyInDB.health.rawValue)) ?? 0
        extremities =   (try? unboxer.unbox(key: ShipInfoKeyInDB.extremities.rawValue)) ?? Range()
        total =         (try? unboxer.unbox(key: ShipInfoKeyInDB.total.rawValue)) ?? 0
        citadel =       (try? unboxer.unbox(key: ShipInfoKeyInDB.citadel.rawValue)) ?? Range()
    }
}


struct AntiAircraft: Unboxable {
    let slots: [String: AntiAircraftSlot]
    let defense: Float
    
    init(unboxer: Unboxer) throws {
        slots = (try? unboxer.unbox(key: ShipInfoKeyInDB.slots.rawValue)) ?? [:]
        defense = (try? unboxer.unbox(key: ShipInfoKeyInDB.defense.rawValue)) ?? 0
    }
}

struct AntiAircraftSlot: Unboxable {
    let distance: Float
    let avg_damage: Float
    let caliber: Float
    let name: String
    let guns: Int
    
    init(unboxer: Unboxer) throws {
        distance = (try? unboxer.unbox(key: ShipInfoKeyInDB.distance.rawValue)) ?? 0
        avg_damage = (try? unboxer.unbox(key: ShipInfoKeyInDB.avg_damage.rawValue)) ?? 0
        caliber = (try? unboxer.unbox(key: ShipInfoKeyInDB.caliber.rawValue)) ?? 0
        name = (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
        guns = (try? unboxer.unbox(key: ShipInfoKeyInDB.guns.rawValue)) ?? 0
    }
}
