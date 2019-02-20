//
//  ConsumableViewModel.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/20/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

struct ConsumableViewModel {
    let sectionTitle: String
    let consumables: [Consumable]
    
    init(sectionTitle: String, consumables: [Consumable]) {
        self.sectionTitle = sectionTitle
        self.consumables = consumables
    }
}
