//
//  ServiceManager.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/13/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import UIKit

final class ServiceManager: NSObject {
    
    static let shared = ServiceManager()
    
    private override init() {
        super.init()
    }
    
}


// System

extension ServiceManager {
    
    func openSystemSetting(){
        if let sysUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(sysUrl, options: [:], completionHandler: nil)
        } else {
            DLog("[INFO] unable to openSystemSetting")
        }
    }
    
}


// Language

enum SystemLanguage {
    case en, cn, cnt
}

enum AppLanguage: String {
    case english = "en"
    case simplifiedChinese = "zh-CN"
    case traditionalChinese = "zh-Hant"
    
    func selectorTitle() -> String {
        switch self {
        case .simplifiedChinese:
            return L("settings.change-language.simplified-chinese")
        case .traditionalChinese:
            return L("settings.change-language.tranditional-chinese")
        default:
            return L("settings.change-language.english")
        }
    }
}

extension ServiceManager {
    
    func getLanguage() -> AppLanguage {
        // User setted language:
        if let locality = UserDefaults.standard.object(forKey: UserDefaultKeys.appLanguages.rawValue) as? [String] {
            if let currentLanguage = locality.first, let appLanguage = AppLanguage(rawValue: currentLanguage) {
                return appLanguage
            }
        }
        // if user does NOT setup AppLanguae, use System default language:
        let systemLanguage = getSystemLanguage()
        switch systemLanguage {
        case .cn:
            return AppLanguage.simplifiedChinese
        case .cnt:
            return AppLanguage.traditionalChinese
        case .en:
            return AppLanguage.english
        }
    }
    
    func setLanguage(_ language: AppLanguage) {
        UserDefaults.standard.set([language.rawValue], forKey: UserDefaultKeys.appLanguages.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    /// 获得当前手机系统的语言
    func getSystemLanguage() -> SystemLanguage {
        if let currLanguage = Bundle.main.preferredLocalizations.first {
            switch String(describing: currLanguage) {
            case "en", "EN", "en-US", "en-CN":
                return SystemLanguage.en // English
            case "cn", "zh-Hans-US","zh-Hans-CN","zh-Hans":
                return SystemLanguage.cn // Chinese
            case "zh-Hant-CN","zh-TW","zh-HK":
                return SystemLanguage.cnt // Chinese-Traditional
            default:
                return SystemLanguage.cn
            }
        }
        return SystemLanguage.cn // Default using CN
    }
    
    func getShipDescriptionLanguage() -> String {
        let currLanguage = getLanguage()
        switch currLanguage {
        case .simplifiedChinese:
            return "zh-cn"
        case .traditionalChinese:
            return "zh-tw"
        default:
            return "en"
        }
    }
}
