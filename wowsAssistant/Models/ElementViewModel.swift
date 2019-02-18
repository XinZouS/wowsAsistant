//
//  ElementViewModel.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

struct ElementViewModel {
    
    let title: String
    let content: [ElementContent]
    
    init(title: String, content: [ElementContent]) {
        self.title = title
        self.content = content
    }
    
}

struct ElementContent {
    let description: String
    let iconUrlStr: String
    
    init(urlStr: String, description: String) {
        self.iconUrlStr = urlStr
        self.description = description
    }
}
