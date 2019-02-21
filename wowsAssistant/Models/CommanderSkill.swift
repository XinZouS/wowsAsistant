//
//  CommanderSkill.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import Unbox

struct CommanderSkill: Unboxable {
    let name: String
    let typeId: Int      // could sort by this id
    let typeName: String // the type of this skill
    let perks: [String]  // description, no id
    let tier: Int
    let icon: String
    
    init(unboxer: Unboxer) throws {
        name = (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
        typeId = (try? unboxer.unbox(key: ShipInfoKeyInDB.typeId.rawValue)) ?? 0
        typeName = (try? unboxer.unbox(key: ShipInfoKeyInDB.typeName.rawValue)) ?? ""
        let dictionarys: [[String:Any]] = (try? unboxer.unbox(key: ShipInfoKeyInDB.perks.rawValue)) ?? []
        tier = (try? unboxer.unbox(key: ShipInfoKeyInDB.tier.rawValue)) ?? 0
        icon = (try? unboxer.unbox(key: ShipInfoKeyInDB.icon.rawValue)) ?? ""
        
        var getDescriptions: [String] = []
        for pair in dictionarys {
            if let s = pair[ShipInfoKeyInDB.description.rawValue] as? String {
                getDescriptions.append(s)
            }
        }
        perks = getDescriptions
    }
    
    func getPerksDescription() -> String {
        return perks.reduce("") { "\($0)\($1)\n" }
    }
}
