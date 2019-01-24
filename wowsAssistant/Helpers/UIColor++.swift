//
//  UIColor++.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    
    struct WowsTheme {
        static let gradientEdge = #colorLiteral(red: 0.004686305299, green: 0.08442083746, blue: 0.1674652398, alpha: 1)
        static let gradientCenter = #colorLiteral(red: 0.09997541457, green: 0.2214729786, blue: 0.3295043409, alpha: 1)
        
        static let lineLightBlue = #colorLiteral(red: 0.2062162139, green: 0.3627479374, blue: 0.5017203692, alpha: 1)
        
    }
    
}
