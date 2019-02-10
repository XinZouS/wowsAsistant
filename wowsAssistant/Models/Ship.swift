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
    var hull:           Hull?
    var engine:         Engine?
    var mobility:       Mobility?
    var armour:         Armour?
    var weaponry:       Weaponry?
    var artillery:      Artillery?
    var atbas:          Atbas?
    var fire_control:   FireControl?
    var torpedoes:      Torpedoes?
    var concealment:    Concealment?
    var anti_aircraft:  AntiAircraft?
    var flight_control: FlightControl?
    var fighters:       Fighters?
    var torpedo_bomber: TorpedoBomber?
    var dive_bomber:    DiveBomber?
    var battle_level_range_max: Int = 0
    var battle_level_range_min: Int = 0
    
    required init(unboxer: Unboxer) throws {
        engine =        try? unboxer.unbox(key: ShipInfoKeyInDB.engine.rawValue)
        torpedo_bomber = try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_bomber.rawValue)
        anti_aircraft = try? unboxer.unbox(key: ShipInfoKeyInDB.anti_aircraft.rawValue)
        mobility =      try? unboxer.unbox(key: ShipInfoKeyInDB.mobility.rawValue)
        hull =          try? unboxer.unbox(key: ShipInfoKeyInDB.hull.rawValue)
        atbas =         try? unboxer.unbox(key: ShipInfoKeyInDB.atbas.rawValue)
        artillery =     try? unboxer.unbox(key: ShipInfoKeyInDB.artillery.rawValue)
        torpedoes =     try? unboxer.unbox(key: ShipInfoKeyInDB.torpedoes.rawValue)
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
    
    // TODO: use L() for name Strings
    func getNameAndValuePairs() -> [Pair] {
        let p: [Pair] = [Pair("Engine max speed", "\(Int(max_speed))")]
        return p
    }
}

struct Hull: Unboxable {
    let hull_id: Int
    let hull_id_str: String
    let range: Range
    let health: Int
    let artillery_barrels: Int
    let atba_barrels: Int
    let torpedoes_barrels: Int
    let anti_aircraft_barrels: Int
    let planes_amount: Int
    
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
    
    /**
     * [Health, Range, Artillery, Secondary, Anti-air, Planes amount]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        // TODO: use L() for name Strings
        p.append(Pair("Health", health))
        p.append(Pair("Range", range.getDescription()))
        p.append(Pair("Artillery barrels", artillery_barrels))
        p.append(Pair("Secondary barrels", atba_barrels))
        p.append(Pair("Torpedoes barrels", torpedoes_barrels))
        p.append(Pair("Anti-aircraft barrels", anti_aircraft_barrels))
        p.append(Pair("Planes amount", planes_amount))
        return p
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
    
    // TODO: use L() for name Strings
    /**
     * [Rudder shift time, turning radius, max speed]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("Rudder shift time", rudder_time))
        p.append(Pair("Turning radius", turning_radius))
        p.append(Pair("Max speed", max_speed))
        return p
    }
    
    // TODO: use L() for name Strings
    func getSummationDescription() -> Pair {
        return Pair("Maneuverability", total)
    }
}

struct Atbas: Unboxable {
    let distance: Float
    let slots: [String: AtbasSlotModel]
    
    init(unboxer: Unboxer) throws {
        distance = (try? unboxer.unbox(key: ShipInfoKeyInDB.distance.rawValue)) ?? 0
        slots = (try? unboxer.unbox(key: ShipInfoKeyInDB.slots.rawValue)) ?? [:]
    }
    
    // TODO: use L() for name Strings
    /**
     * [Secondary slots]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("Distance", distance))
        for slot in slots {
            let slotModel = slot.value
            p.append(contentsOf: slotModel.getNameAndValuePairs())
        }
        return p
    }
}

struct AtbasSlotModel: Unboxable {
    let name: String
    let type: String // "HE", "AP"
    let burn_probability: Float
    let bullet_speed: Int
    let bullet_mass: Int
    let shot_delay: Float
    let damage: Int
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
    
    // TODO: use L() for name Strings
    /**
     * [Damage, burn%, shot delay, bullet speed, bullet mass, gun rate]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("\(type) - \(name)", ""))
        p.append(Pair("Damage", damage))
        p.append(Pair("Burn probability", "\(burn_probability)%"))
        p.append(Pair("Shot delay", shot_delay))
        p.append(Pair("Bullet speed", bullet_speed))
        p.append(Pair("Bullet mass", bullet_mass))
        p.append(Pair("Gun rate", gun_rate))
        return p
    }
}

/// Sum num of ship capability
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
    
    // TODO: use L() for name Strings
    func getArtilleryNameAndValuePair() -> Pair {
        return Pair("Artillery", artillery)
    }
    func getTorpedoesNameAndValuePair() -> Pair {
        return Pair("Torpedoes", torpedoes)
    }
    func getAAGunsNameAndValuePair() -> Pair {
        return Pair("AA Guns", anti_aircraft)
    }
    func getAircraftNameAndValuePair() -> Pair {
        return Pair("Aircraft", aircraft)
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
    
    // TODO: use L() for name Strings
    /**
     * ⚠️ this only giving details, Summation is in Ship.weaponry.artillery
     * [Shot delay, 180r time, firing range, max dispersion]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        for shell in shells {
            p.append(contentsOf: shell.value.getNameAndValuePairs())
        }
        p.append(Pair("Gun rate", gun_rate))
        p.append(Pair("Shot delay", shot_delay))
        p.append(Pair("180 rotation time", rotation_time))
        p.append(Pair("Firing range", distance))
        p.append(Pair("Max dispersion", max_dispersion))
        for slot in slots {
            p.append(contentsOf: slot.value.getNameAndValuePairs())
        }
        return p
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
    
    // TODO: use L() for name Strings
    /**
     * [bullet speed, shell weight, chance of fire on target, maximun damage]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("\(type) - \(name)", ""))
        p.append(Pair("  Bullet speed", bullet_speed))
        p.append(Pair("  Shell weight", bullet_mass))
        p.append(Pair("  Chance of Fire on target", "\(burn_probability)%"))
        p.append(Pair("  Maximum damage", damage))
        return p
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
    
    /// sloats: [name, x guns]
    func getNameAndValuePairs() -> [Pair] {
        return [Pair("\(name)", "x\(guns)")]
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
    
    // TODO: use L() for name Strings
    /**
     * [firing range, extension]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("Firing range", distance))
        p.append(Pair("Firing Range extension", "\(distance_increase)%"))
        return p
    }
}

struct Torpedoes: Unboxable {
    let torpedoes_id: Int
    let torpedoes_id_str: String
    let visibility_dist: Float
    let distance: Float
    let torpedo_name: String
    let reload_time: Int
    let torpedo_speed: Float
    let rotation_time: Float
    let slots: [String: TorpedoeSlots]
    let max_damage: Int
    
    init(unboxer: Unboxer) throws {
        torpedoes_id = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedoes_id.rawValue)) ?? 0
        torpedoes_id_str = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedoes_id_str.rawValue)) ?? ""
        visibility_dist = (try? unboxer.unbox(key: ShipInfoKeyInDB.visibility_dist.rawValue)) ?? 0
        distance = (try? unboxer.unbox(key: ShipInfoKeyInDB.distance.rawValue)) ?? 0
        torpedo_name = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_name.rawValue)) ?? ""
        reload_time = (try? unboxer.unbox(key: ShipInfoKeyInDB.reload_time.rawValue)) ?? 0
        torpedo_speed = (try? unboxer.unbox(key: ShipInfoKeyInDB.torpedo_speed.rawValue)) ?? 0
        rotation_time = (try? unboxer.unbox(key: ShipInfoKeyInDB.rotation_time.rawValue)) ?? 0
        slots = (try? unboxer.unbox(key: ShipInfoKeyInDB.slots.rawValue)) ?? [:]
        max_damage = (try? unboxer.unbox(key: ShipInfoKeyInDB.max_damage.rawValue)) ?? 0
    }
    
    // TODO: use L() for name Strings
    /**
     * [Name, 180turn, maxDmg, reload, range, speed, visibility]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("Torpedo", torpedo_name))
        p.append(Pair("180 Degree Turn", "\(rotation_time) sec"))
        p.append(Pair("Maximum Damage", max_damage))
        p.append(Pair("Reload Time", "\(reload_time) sec"))
        p.append(Pair("Torpedoes range", distance))
        p.append(Pair("Speed", "\(torpedo_speed) knots"))
        p.append(Pair("Visibility", "\(visibility_dist) km"))
        for slot in slots {
            p.append(Pair("Slot \(slot.key)", ""))
            p.append(contentsOf: slot.value.getNameAndValuePairs())
        }
        return p
    }
}

struct TorpedoeSlots: Unboxable {
    let barrels: Int
    let caliber: Int
    let name: String
    let guns: Int
    
    init(unboxer: Unboxer) throws {
        barrels = (try? unboxer.unbox(key: ShipInfoKeyInDB.barrels.rawValue)) ?? 0
        caliber = (try? unboxer.unbox(key: ShipInfoKeyInDB.caliber.rawValue)) ?? 0
        name = (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
        guns = (try? unboxer.unbox(key: ShipInfoKeyInDB.guns.rawValue)) ?? 0
    }
    
    // TODO: use L() for name Strings
    /**
     * [name, caliber, tubes num, tubes per slot]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("  Name", name))
        p.append(Pair("  Caliber", caliber))
        p.append(Pair("  Torpedo tubes", guns))
        p.append(Pair("  Torpedo tubes per slot", barrels))
        return p
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
    
    // TODO: use L() for name Strings
    /**
     * [detectability range, air detectability range]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("Detectability Range", detect_distance_by_ship))
        p.append(Pair("Air Detectability Range", detect_distance_by_plane))
        return p
    }
    
    // TODO: use L() for name Strings
    func getSummationDescription() -> Pair {
        return Pair("Concealment", total)
    }
}

struct Armour: Unboxable {
    let total: Int
    let health: Int
    let range: Range
    let casemate: Range
    let deck: Range
    let citadel: Range
    let extremities: Range
    let flood_prob: Float
    let flood_damage: Float
    
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
    
    // TODO: use L() for name Strings
    /**
     * [Hit points, armour, gun casemate, citadel, armored deck, forward and after ends, torp protect flooding, damage reduction]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("Hit points", health))
        p.append(Pair("Armour", range.getDescription()))
        p.append(Pair("Gun Casemate", casemate.getDescription()))
        p.append(Pair("Citadel", citadel.getDescription()))
        p.append(Pair("Armored Deck", deck.getDescription()))
        p.append(Pair("Forward and After Ends", extremities.getDescription()))
        p.append(Pair("Torpedo Protection \nFlooding Risk Reduction", "\(flood_prob)%"))
        p.append(Pair("Torpedo Protection \nDamage Reduction", "\(flood_damage)%"))
        return p
    }
    
    // TODO: use L() for name Strings
    func getSummationDescription() -> Pair {
        return Pair("Survivability", total)
    }
}


struct AntiAircraft: Unboxable {
    let slots: [String: AntiAircraftSlot]
    let defense: Float
    
    init(unboxer: Unboxer) throws {
        slots = (try? unboxer.unbox(key: ShipInfoKeyInDB.slots.rawValue)) ?? [:]
        defense = (try? unboxer.unbox(key: ShipInfoKeyInDB.defense.rawValue)) ?? 0
    }
    
    // TODO: use L() for name Strings
    /**
     * [Effectiveness]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("Effectiveness", defense))
        for slot in slots {
            p.append(contentsOf: slot.value.getNameAndValuePairs())
        }
        return p
    }
}

struct AntiAircraftSlot: Unboxable {
    let distance: Float
    let avg_damage: Int
    let caliber: Int
    let name: String
    let guns: Int
    
    init(unboxer: Unboxer) throws {
        distance = (try? unboxer.unbox(key: ShipInfoKeyInDB.distance.rawValue)) ?? 0
        avg_damage = (try? unboxer.unbox(key: ShipInfoKeyInDB.avg_damage.rawValue)) ?? 0
        caliber = (try? unboxer.unbox(key: ShipInfoKeyInDB.caliber.rawValue)) ?? 0
        name = (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
        guns = (try? unboxer.unbox(key: ShipInfoKeyInDB.guns.rawValue)) ?? 0
    }
    
    // TODO: use L() for name Strings
    /**
     * [Firing range, name, avgDmg, Caliber]
     */
    func getNameAndValuePairs() -> [Pair] {
        var p: [Pair] = []
        p.append(Pair("Firing range", "\(distance) km"))
        p.append(Pair("\(name)", "x \(guns)"))
        p.append(Pair("Average damage", "\(avg_damage)/s"))
        p.append(Pair("Caliber", "\(caliber) mm"))
        return p
    }
}
