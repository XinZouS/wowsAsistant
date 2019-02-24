//
//  Map.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import Unbox


struct Map: Unboxable {
    let battle_arena_id: Int
    let description: String
    let icon: String
    let name: String
    
    init(unboxer: Unboxer) throws {
        battle_arena_id = (try? unboxer.unbox(key: ShipInfoKeyInDB.battleArenaId.rawValue)) ?? 0
        description = (try? unboxer.unbox(key: ShipInfoKeyInDB.description.rawValue)) ?? ""
        icon = (try? unboxer.unbox(key: ShipInfoKeyInDB.icon.rawValue)) ?? ""
        name = (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
    }
}
