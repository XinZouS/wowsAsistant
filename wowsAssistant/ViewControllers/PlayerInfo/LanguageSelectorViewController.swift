//
//  LanguageSelectorViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/13/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class LanguageSelectorViewController: UITableViewController {
    
    let languageCellId = "SettingsLanguageChangeCell"
    let dataSource = [AppLanguage.english, AppLanguage.simplifiedChinese]
    var selectedIndexPath: IndexPath?
    let currentLanguage = ServiceManager.shared.getLanguage()
    
    
    
}

