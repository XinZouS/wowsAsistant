//
//  ElementViewModel.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

struct ElementViewModel {
    
    /// section title string
    let title: String
    /// for rows or items, with "description" and "iconUrlStr"
    let contents: [ElementContent]
    
    init(title: String, contents: [ElementContent]) {
        self.title = title
        self.contents = contents
    }
    
}

struct ElementContent {
    let description: String
    let iconUrlStr: String
    let price: Int
    
    init(urlStr: String, description: String, price: Int) {
        self.iconUrlStr = urlStr
        self.description = description
        self.price = price
    }
}
