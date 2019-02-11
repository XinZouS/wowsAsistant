//
//  ShipViewModel.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/11/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

class ShipViewModel {
    var isExpanded = true
    var sectionPair: Pair?
    var contentPairs: [Pair] = []
    
    init(sectionPair p: Pair) {
        self.sectionPair = p
    }
}
