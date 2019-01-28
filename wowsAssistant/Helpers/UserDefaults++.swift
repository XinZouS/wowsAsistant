//
//  UserDefaults++.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

enum UserDefaultKeys: String {
    case appLanguages = "AppleLanguages"
    case serverRelamKey = "wows-assistant.user-default.key.server-relam"
    case nextTimeUpdateShipBasicInfo = "wows-assistant.user-default.key.next-time-update-basic"
}

extension UserDefaults {
    
    // Server Relam
    static func setServerRelam(_ sr: ServerRealm) {
        UserDefaults.standard.set(sr.rawValue, forKey: UserDefaultKeys.serverRelamKey.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getServerRelam() -> ServerRealm {
        if let rl = UserDefaults.standard.string(forKey: UserDefaultKeys.serverRelamKey.rawValue), let sr = ServerRealm(rawValue: rl) {
            return sr
        }
        return .na // default
    }
    
    /// ShipBasicInfo update time: Int
    static func setNextTimeUpdateShipBasicInfo(seconds: Int) {
        let delay = Date.getTimestampNow() + seconds
        UserDefaults.standard.set(delay, forKey: UserDefaultKeys.nextTimeUpdateShipBasicInfo.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    /// To compair with Date.getTimestampNow() and see if Now > nextTime;
    static func getNextTimeUpdateShipBasicInfo() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaultKeys.nextTimeUpdateShipBasicInfo.rawValue)
    }
    
}
