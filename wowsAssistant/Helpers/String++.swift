//
//  String++.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/13/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation

extension String {
    
    // ONLY FOR THIS SERVER!!! KNOW YOUR PURPOSE BEFORE USING IT!
    func isTrue() -> Bool {
        return self.lowercased() == "true" || self == "1"
    }
    
    func isFalse() -> Bool {
        return self.lowercased() == "false" || self == "0"
    }
    
    func toBool() -> Bool {
        if self.lowercased() == "false" || self == "0" {
            return false
        }
        return true
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                DLog(error.localizedDescription)
            }
        }
        return nil
    }
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    func removeWhitespaces(_ onlyTarget: String? = nil) -> String {
        if let target = onlyTarget {
            return components(separatedBy: target).joined()
        }
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    /// ONLY use for a url string, otherwise will do nothing and return the same string;
    func replaceUrlLastPathComponent(with newComponent: String) -> String {
        if let url = URL(string: self) {
            let truncateUrl = url.deletingLastPathComponent()
            let newUrl = truncateUrl.appendingPathComponent(newComponent)
            return newUrl.absoluteString
        }
        return self
    }
}
