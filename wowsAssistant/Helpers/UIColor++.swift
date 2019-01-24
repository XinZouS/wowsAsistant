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
        static let buttonRedTop = #colorLiteral(red: 0.9903886914, green: 0.382309854, blue: 0.002325810259, alpha: 1)
        static let buttonRedBot = #colorLiteral(red: 0.8842617273, green: 0.1837858558, blue: 0, alpha: 1)
        
        static let buttonGreenTop = #colorLiteral(red: 0.002993121278, green: 0.5853926539, blue: 0.5872872472, alpha: 1)
        static let buttonGreenBot = #colorLiteral(red: 0, green: 0.4165538549, blue: 0.4138219357, alpha: 1)
        
        static let gradientEdge = #colorLiteral(red: 0.004686305299, green: 0.08442083746, blue: 0.1674652398, alpha: 1)
        static let gradientCenter = #colorLiteral(red: 0.09997541457, green: 0.2214729786, blue: 0.3295043409, alpha: 1)
        
        static let lineDarkBlue = #colorLiteral(red: 0.2062162139, green: 0.3627479374, blue: 0.5017203692, alpha: 1)
        static let lineCyan = #colorLiteral(red: 0.4664868116, green: 0.9307252765, blue: 0.9329747558, alpha: 1)
        
    }
    
}
