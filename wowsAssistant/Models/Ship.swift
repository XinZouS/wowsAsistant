//
//  Ship.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/13/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

struct Ship {
    let engine: Engine
    let torpedo_bomber: TorpedoBomber
    let anti_aircraft: AntiAircraft
    let mobility: Mobility
    let hull: Hull
    let atbas: Atbas
    let artillery: Artillery
    let torpedoes: [Int]
    let fighters: Fighters
    let fire_control: FireControl
    let weaponry: Weaponry
    let battle_level_range_max: Int
    let battle_level_range_min: Int
    let flight_control: FlightControl
    let concealment: Concealment
    let armour: Armour
    let dive_bomber: DiveBomber
}

struct Engine {
    let engine_id: Int
    let engine_id_str: String
    let max_speed: Float
}

struct Hull {
    let hull_id: Int
    let hull_id_str: String
    let torpedoes_barrels: Int
    let anti_aircraft_barrels: Int
    let range: Range
    let health: Int
    let planes_amount: Int
    let artillery_barrels: Int
    let atba_barrels: Int
}

struct Mobility {
    let rudder_time: Float
    let total: Float
    let turning_radius: Float
    let max_speed: Float
}

struct Atbas {
    let distance: Int
    let slots: [String: AtbasSlotModel]
}

struct AtbasSlotModel {
    let burn_probability: Float
    let bullet_speed: Int
    let name: String
    let shot_delay: Float
    let damage: Int
    let bullet_mass: Int
    let type: String // "HE", "AP"
    let gun_rate: Float
}

struct Artillery {
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

struct Shell {
    let burn_probability: Float
    let bullet_speed: Int
    let name: String
    let damage: Int
    let bullet_mass: Int
    let type: String //"AP"
}

struct ArtillerySlot {
    let barrels: Int
    let name: String
    let guns: Int
}

struct FireControl {
    let fire_control_id: Int
    let fire_control_id_str: String
    let distance: Float
    let distance_increase: Float
}

struct Weaponry {
    let anti_aircraft: Int
    let aircraft: Int
    let artillery: Int
    let torpedoes: Int
}

struct Concealment {
    let total: Int
    let detect_distance_by_plane: Float
    let detect_distance_by_ship: Float
}

struct Armour {
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


struct AntiAircraft {
    let slots: [String: AntiAircraftSlot]
    let defense: Float
    
}

struct AntiAircraftSlot {
    let distance: Float
    let avg_damage: Float
    let caliber: Float
    let name: String
    let guns: Int
}
