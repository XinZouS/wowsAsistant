//
//  UserDefaults++.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

let serverRelamKey = "wows-assistant.user-default.key.server-relam"

extension UserDefaults {
    
    // Server Relam
    static func setServerRelam(_ sr: ServerRealm) {
        UserDefaults.standard.set(sr.rawValue, forKey: serverRelamKey)
        UserDefaults.standard.synchronize()
    }
    
    static func getServerRelam() -> ServerRealm {
        if let rl = UserDefaults.standard.string(forKey: serverRelamKey), let sr = ServerRealm(rawValue: rl) {
            return sr
        }
        return .na // default
    }
    
}
