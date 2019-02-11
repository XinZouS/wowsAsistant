//
//  Consumable.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/11/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import Unbox

struct Consumable: Unboxable {
    
    let consumableId: Int
    let profiles: [ConsumableProfile]
    let name: String
    let image: String
    let priceGold: Int
    let priceCredit: Int
    let type: String
    let description: String
    
    init(unboxer: Unboxer) throws {
        consumableId = (try? unboxer.unbox(key: ShipInfoKeyInDB.consumableId.rawValue)) ?? 0
        name = (try? unboxer.unbox(key: ShipInfoKeyInDB.name.rawValue)) ?? ""
        image = (try? unboxer.unbox(key: ShipInfoKeyInDB.image.rawValue)) ?? ""
        priceGold = (try? unboxer.unbox(key: ShipInfoKeyInDB.price_gold.rawValue)) ?? 0
        priceCredit = (try? unboxer.unbox(key: ShipInfoKeyInDB.price_credit.rawValue)) ?? 0
        type = (try? unboxer.unbox(key: ShipInfoKeyInDB.type.rawValue)) ?? ""
        description = (try? unboxer.unbox(key: ShipInfoKeyInDB.description.rawValue)) ?? ""
        
        var pArray: [ConsumableProfile] = []
        /// convenience for unboxer
        if let profileDictionary: [String: [String:Any]] = try? unboxer.unbox(key: ShipInfoKeyInDB.profile.rawValue) {
            for pair in profileDictionary {
                let profile = ConsumableProfile(name: pair.key, dictionary: pair.value)
                pArray.append(profile)
            }
        }
        self.profiles = pArray
    }
    
}


struct ConsumableProfile {
    let name: String
    let description: String
    let value: Float
    
    init(name: String, dictionary: [String:Any]) {
        self.name = name
        if let s = dictionary[ShipInfoKeyInDB.description.rawValue] as? String {
            description = s
        } else {
            description = ""
        }
        if let v = dictionary[ShipInfoKeyInDB.value.rawValue] as? Float {
            value = v
        } else {
            value = 0.0
        }
    }
}
