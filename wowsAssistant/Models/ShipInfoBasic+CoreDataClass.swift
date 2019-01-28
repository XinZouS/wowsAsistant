//
//  ShipInfoBasic+CoreDataClass.swift
//  
//
//  Created by Xin Zou on 1/27/19.
//
//

import Foundation
import CoreData
import Unbox

public class ShipInfoBasic: NSManagedObject {

    func setupByDictionary(_ dictionary: [String:Any]) {
        if let id = dictionary[ShipInfoKeyInDB.ship_id.rawValue] as? Int64 {
            ship_id = id
        }
        if let t = dictionary[ShipInfoKeyInDB.type.rawValue] as? String {
            self.type = t
        }
        if let na = dictionary[ShipInfoKeyInDB.nation.rawValue] as? String {
            self.nation = na
        }
        if let ti = dictionary[ShipInfoKeyInDB.tier.rawValue] as? Int32 {
            self.tier = ti
        }
    }
    
}
