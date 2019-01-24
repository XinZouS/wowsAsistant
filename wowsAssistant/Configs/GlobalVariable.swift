//
//  GlobalVariable.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/13/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Info
enum ServerRealm: String {
    case ru = "ru"
    case eu = "eu"
    case na = "com"
    case asia = "asia"
    
    func descriptionString() -> String {
        switch self {
        case .ru:
            return "R.U."
        case .eu:
            return "E.U."
        case .na:
            return "N.A."
        case .asia:
            return "Asia"
        }
    }
}

enum ShipNation: String, CaseIterable {
    case pan_asia = "pan_asia"
    case usa = "usa"
    case ussr = "ussr"
    case uk = "uk"
    case germany = "germany"
    case france = "france"
    case commonwealth = "commonwealth"
    case pan_america = "pan_america"
    case italy = "italy"
    case poland = "poland"
    case japan = "japan"
    
    func displayName() -> String {
        switch self {
        case .pan_asia:
            return "Pan-Asia"
        case .usa:
            return "U.S.A."
        case .ussr:
            return "U.S.S.R."
        case .uk:
            return "U.K."
        case .germany:
            return "Germany"
        case .france:
            return "France"
        case .commonwealth:
            return "Commonwealth"
        case .italy:
            return "Italy"
        case .poland:
            return "Poland"
        case .japan:
            return "Japan"
        case .pan_america:
            return "Pan-America"
        }
    }
    
    func flag(_ isBackgroud: Bool = false) -> UIImage {
        switch self {
        case .pan_asia:
            return isBackgroud ? #imageLiteral(resourceName: "flagPanAsia") : #imageLiteral(resourceName: "flagIcon_pan_asia")
        case .usa:
            return isBackgroud ? #imageLiteral(resourceName: "flagUSA") : #imageLiteral(resourceName: "flagIcon_usa")
        case .ussr:
            return isBackgroud ? #imageLiteral(resourceName: "flagUSSR") : #imageLiteral(resourceName: "flagIcon_ussr")
        case .uk:
            return isBackgroud ? #imageLiteral(resourceName: "flagUK") : #imageLiteral(resourceName: "flagIcon_uk")
        case .germany:
            return isBackgroud ? #imageLiteral(resourceName: "flagGerman") : #imageLiteral(resourceName: "flagIcon_german")
        case .france:
            return isBackgroud ? #imageLiteral(resourceName: "flagFrance") : #imageLiteral(resourceName: "flagIcon_france")
        case .commonwealth:
            return isBackgroud ? #imageLiteral(resourceName: "flagCommonwealth") : #imageLiteral(resourceName: "flagIcon_comm")
        case .italy:
            return isBackgroud ? #imageLiteral(resourceName: "flagItaly") : #imageLiteral(resourceName: "flagIcon_italy")
        case .poland:
            return isBackgroud ? #imageLiteral(resourceName: "flagPoland") : #imageLiteral(resourceName: "flagIcon_poland")
        case .japan:
            return isBackgroud ? #imageLiteral(resourceName: "flagJapan") : #imageLiteral(resourceName: "flagIcon_japan")
        case .pan_america:
            return isBackgroud ? #imageLiteral(resourceName: "flagPanAmerica") : #imageLiteral(resourceName: "flagIcon_pan_america")
        }
    }
}

/// [0, 11], eligiable range = [1, 10]
let ShipTierString: [Int:String] = [0:"0", 1:"I", 2:"II", 3:"III", 4:"IV", 5:"V", 6:"VI", 7:"VII", 8:"VIII", 9:"IX", 10:"X", 11:"XI"]

enum IconType: String {
    case normal = "normal"
    case premium = "premium"
    case elite = "elite"
}

enum ShipType: String, CaseIterable {
    case AC = "AirCarrier"
    case BB = "Battleship"
    case CR = "Cruiser"
    case DD = "Destroyer"
    case SB = "Submarine"
        
    // https://developers.wargaming.net/reference/all/wows/encyclopedia/info/?application_id=a604db0355085bac597c209b459fd0fb&r_realm=eu&run=1
    func iconImageUrl(_ iconType: IconType = .normal) -> String {
        let route = "http://glossary-eu-static.gcdn.co/icons/wows/current/vehicle/types/"
        return "\(route)\(self.rawValue)/\(iconType.rawValue).png"
    }
    
    func tagInt() -> Int {
        switch self {
        case .AC:
            return 0
        case .BB:
            return 1
        case .CR:
            return 2
        case .DD:
            return 3
        case .SB:
            return 4
        }
    }
}

// MARK: - Background images
enum BackgroundImageUrl: String {
    case ships01 = "http://s1.1zoom.me/big3/55/World_Of_Warship_Ships_Eagles_Battleship_German_521573_2560x1600.jpg"
}


//MARK: - Helper Methods

func debugLog(_ message: String,
              function: String = #function,
              file: String = #file,
              line: Int = #line) {
    DLog("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
}

func DLog(_ message: String) {
    #if DEBUG
    print(message)
    #endif
}

func L(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
