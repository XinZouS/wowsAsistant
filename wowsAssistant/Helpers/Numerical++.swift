//
//  Numerical++.swift
//  wowsAssistant
//
//  🦋 Customized func for Int, CGFloat, Double... any Numerical class
//
//  Created by Xin Zou on 2/21/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

extension Int {
    
    /// 66666666 -> 66,666,666
    func getFormattedString() -> String {
        var rlt = ""
        var num = self
        var mod = 0
        var countOfDigits = 0
        let dec = 10
        
        while num > 0 {
            mod = num % dec
            if countOfDigits > 0, countOfDigits % 3 == 0 {
                rlt = "\(mod),\(rlt)"
            } else {
                rlt = "\(mod)\(rlt)"
            }
            num -= mod
            num = num / dec
            countOfDigits += 1
        }
        return rlt
    }
    
}
