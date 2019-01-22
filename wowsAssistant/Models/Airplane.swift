//
//  Airplane.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import Unbox

struct FlightControl: Unboxable {
    let flight_control_id: Int
    let flight_control_id_str: String
    let bomber_squadrons: Int
    let torpedo_squadrons: Int
    let fighter_squadrons: Int
    
    init(unboxer: Unboxer) throws {
        flight_control_id = (try? unboxer.unbox(key: ShipInfoKeyInDB.flight_control_id.rawValue)) ?? 0
        flight_control_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.flight_control_id_str.rawValue)) ?? ""
        bomber_squadrons = (try? unboxer.unbox(key: ShipInfoKeyInDB.bomber_squadrons.rawValue)) ?? 0
        torpedo_squadrons = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_squadrons.rawValue)) ?? 0
        fighter_squadrons = (try? unboxer.unbox(key: ShipInfoKeyInDB.fighter_squadrons.rawValue)) ?? 0
    }
}

class Airplane: Unboxable {
    var squadrons: Int
    var count_in_squadron: Range
    var name: String
    var cruise_speed: Int
    var prepare_time: Int
    var gunner_damage: Int
    var plane_level: Int
    var max_health: Int
    
    required init(unboxer: Unboxer) throws {
        squadrons = (try? unboxer.unbox(key: ShipInfoKeyInDB.squadrons.rawValue)) ?? 0
        name = (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
        cruise_speed = (try? unboxer.unbox(key: ShipInfoKeyInDB.cruise_speed.rawValue)) ?? 0
        prepare_time = (try? unboxer.unbox(key: ShipInfoKeyInDB.prepare_time.rawValue)) ?? 0
        gunner_damage = (try? unboxer.unbox(key: ShipInfoKeyInDB.gunner_damage.rawValue)) ?? 0
        count_in_squadron = (try? unboxer.unbox(key: ShipInfoKeyInDB.count_in_squadron.rawValue)) ?? Range()
        plane_level = (try? unboxer.unbox(key: ShipInfoKeyInDB.plane_level.rawValue)) ?? 0
        max_health = (try? unboxer.unbox(key: ShipInfoKeyInDB.max_health.rawValue)) ?? 0
    }
}


class Fighters: Airplane {
    var fighters_id: Int
    var fighters_id_str: String
    var avg_damage: Int
    var max_ammo: Int
    
    required init(unboxer: Unboxer) throws {
        fighters_id = (try? unboxer.unbox(key: ShipInfoKeyInDB.fighters_id.rawValue)) ?? 0
        fighters_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.fighters_id_str.rawValue)) ?? ""
        max_ammo = (try? unboxer.unbox(key: ShipInfoKeyInDB.max_ammo.rawValue)) ?? 0
        avg_damage = (try? unboxer.unbox(key: ShipInfoKeyInDB.avg_damage.rawValue)) ?? 0
        try super.init(unboxer: unboxer)
    }
}

class TorpedoBomber: Airplane {
    var torpedo_bomber_id: Int
    var torpedo_bomber_id_str: String
    var torpedo_distance: Float
    var torpedo_damage: Int
    var torpedo_max_speed: Float
    var torpedo_name: String
    var max_damage: Int

    required init(unboxer: Unboxer) throws {
        torpedo_bomber_id = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_bomber_id.rawValue)) ?? 0
        torpedo_bomber_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_bomber_id_str.rawValue)) ?? ""
        torpedo_distance = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_distance.rawValue)) ?? 0
        torpedo_damage = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_damage.rawValue)) ?? 0
        torpedo_max_speed = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_max_speed.rawValue)) ?? 0
        torpedo_name = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_name.rawValue)) ?? ""
        max_damage = (try? unboxer.unbox(key: ShipInfoKeyInDB.max_damage.rawValue)) ?? 0
        try super.init(unboxer: unboxer)
    }
}

class DiveBomber: Airplane {
    var dive_bomber_id: Int
    var dive_bomber_id_str: String
    var bomb_damage: Int
    var bomb_name: String
    var bomb_bullet_mass: Int
    var bomb_burn_probability: Int
    var max_damage: Int
    var accuracy: Range
    
    required init(unboxer: Unboxer) throws {
        dive_bomber_id =    (try? unboxer.unbox(key: ShipInfoKeyInDB.dive_bomber_id.rawValue)) ?? 0
        dive_bomber_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.dive_bomber_id_str.rawValue)) ?? ""
        bomb_damage =       (try? unboxer.unbox(key: ShipInfoKeyInDB.bomb_damage.rawValue)) ?? 0
        bomb_name =         (try? unboxer.unbox(key: ShipInfoKeyInDB.bomb_name.rawValue)) ?? ""
        bomb_bullet_mass =  (try? unboxer.unbox(key: ShipInfoKeyInDB.bomb_bullet_mass.rawValue)) ?? 0
        bomb_burn_probability = (try? unboxer.unbox(key: ShipInfoKeyInDB.bomb_burn_probability.rawValue)) ?? 0
        max_damage =        (try? unboxer.unbox(key: ShipInfoKeyInDB.max_damage.rawValue)) ?? 0
        accuracy =          (try? unboxer.unbox(key: ShipInfoKeyInDB.accuracy.rawValue)) ?? Range()
        try super.init(unboxer: unboxer)
    }
}


