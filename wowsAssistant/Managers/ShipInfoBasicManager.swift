//
//  ShipInfoBasicManager.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/27/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

class ShipInfoBasicManager {
    
    private init() {}
    
    static let shared = ShipInfoBasicManager()
    
    var basics: [ShipInfoBasic] = []
    
    
    /// auto load when app opens up, every 7 days auto update from server
    func loadShipInfoBasicIfNeed() {
        loadShipInfoLocally()
        if basics.count == 0 {
            loadShipInfoFromServerAndSaveCoreData()
            let secondsOneDay = 86400
            UserDefaults.setNextTimeUpdateShipBasicInfo(seconds: secondsOneDay * 10)
        }
    }
    
    /// remove local CoreData for reloading update if needed, should call in AppDelegate
    func removeShipInfoBasicIfNeed() {
        let currTime = Date.getTimestampNow()
        let nextTime = UserDefaults.getNextTimeUpdateShipBasicInfo()
        DLog("[CORE DATA] compair currtime = \(currTime), nextTime = \(nextTime)")
        if currTime > nextTime {
            deleteAllInfo()
        }
    }
    
    private func loadShipInfoLocally() {
        basics = PersistenceManager.shared.fetch(ShipInfoBasic.self)
        DLog("[CORE DATA] load ShipInfo Locally gets: \(basics.count)")
    }
    
    private func loadShipInfoFromServerAndSaveCoreData() {
        let realm = UserDefaults.getServerRelam()
        for p in 1...4 {
            ApiServers.shared.getShipInfoBasicList(realm: realm, pageNum: p) { [weak self] in
                print(p)
                if p == 4 {
                    self?.saveByDelay()
                }
            }
        }
    }
    
    private func saveByDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            PersistenceManager.shared.save()
            DLog("[ShipBasic] ✅ save(): finish GET info from Server.")
        }
    }
    
    /// when the time arrived, remove saved data, and get new one NEXT time app runs
    private func deleteAllInfo() {
        let infos = PersistenceManager.shared.fetch(ShipInfoBasic.self)
        DLog("[CORE DATA] ⚠️ will delete \(infos.count) items!")
        for item in infos {
            PersistenceManager.shared.delete(item)
        }
        PersistenceManager.shared.save()
    }
    
}
