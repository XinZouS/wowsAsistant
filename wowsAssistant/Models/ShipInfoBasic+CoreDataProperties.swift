//
//  ShipInfoBasic+CoreDataProperties.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/28/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//
//

import Foundation
import CoreData


extension ShipInfoBasic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShipInfoBasic> {
        return NSFetchRequest<ShipInfoBasic>(entityName: "ShipInfoBasic")
    }

    @NSManaged public var ship_id: Int64
    @NSManaged public var type: String?
    @NSManaged public var tier: Int32
    @NSManaged public var nation: String?

}
