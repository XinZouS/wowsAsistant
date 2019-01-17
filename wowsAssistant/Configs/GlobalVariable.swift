//
//  GlobalVariable.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/13/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

//MARK: - Info
enum Nation: String {
    case uk = "uk"
}

enum ShipType: String {
    case AC = "AirCarrier"
    case BB = "Battleship"
    case CR = "Cruiser"
    case DD = "Destroyer"
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
