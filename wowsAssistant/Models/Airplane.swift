//
//  Airplane.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

struct TorpedoBomber {
    let torpedo_distance: Float
    let plane_level: Int
    let squadrons: Int
    let name: String
    let cruise_speed: Float
    let prepare_time: Int
    let torpedo_damage: Int
    let count_in_squadron: CountInSquadron
    let torpedo_max_speed: Float
    let torpedo_bomber_id_str: String
    let gunner_damage: Int
    let max_damage: Int
    let max_health: Int
    let torpedo_bomber_id: Int
    let torpedo_name: String
}


struct CountInSquadron {
    let max: Int
    let min: Int
}
