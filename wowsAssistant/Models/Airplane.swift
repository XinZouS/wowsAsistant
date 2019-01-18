//
//  Airplane.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

struct FlightControl {
    let flight_control_id: Int
    let flight_control_id_str: String
    let bomber_squadrons: Int
    let torpedo_squadrons: Int
    let fighter_squadrons: Int
}

struct Fighters {
    let fighters_id: Int
    let fighters_id_str: String
    let squadrons: Int
    let name: String
    let cruise_speed: Int
    let prepare_time: Int
    let gunner_damage: Int
    let count_in_squadron: Range
    let max_ammo: Int
    let plane_level: Int
    let avg_damage: Int
    let max_health: Int
}

struct TorpedoBomber {
    let torpedo_bomber_id: Int
    let torpedo_bomber_id_str: String
    let torpedo_distance: Float
    let plane_level: Int
    let squadrons: Int
    let name: String
    let cruise_speed: Float
    let prepare_time: Int
    let torpedo_damage: Int
    let count_in_squadron: Range
    let torpedo_max_speed: Float
    let gunner_damage: Int
    let max_damage: Int
    let max_health: Int
    let torpedo_name: String
}

struct DiveBomber {
    let dive_bomber_id: Int
    let dive_bomber_id_str: String
    let squadrons: Int
    let name: String
    let cruise_speed: Int
    let prepare_time: Int
    let gunner_damage: Int
    let bomb_damage: Int
    let count_in_squadron: Range
    let bomb_name: String
    let bomb_bullet_mass: Int
    let plane_level: Int
    let bomb_burn_probability: Int
    let max_damage: Int
    let max_health: Int
    let accuracy: Range
}

