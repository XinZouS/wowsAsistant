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
    let dataSource = [AppLanguage.english, AppLanguage.simplifiedChinese, AppLanguage.traditionalChinese]
    var selectedIndexPath: IndexPath?
    let currentLanguage = ServiceManager.shared.getLanguage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = L("settings.ui.title.change-language")
        
        let confirmButton = UIBarButtonItem(title: L("settings.change-language.confirmed"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(handleSaveButton))
        navigationItem.rightBarButtonItem = confirmButton
        
        for i in 0..<dataSource.count {
            if currentLanguage == dataSource[i] {
                selectedIndexPath = IndexPath(item: i, section: 0)
                break
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }
    
    //MARK: - Handle Save
    @objc private func handleSaveButton(sender: UIButton) {
        
        guard let selectedIndexPath = selectedIndexPath, currentLanguage != dataSource[selectedIndexPath.row] else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        let appLanguage = dataSource[selectedIndexPath.row]
        
        //Show alert to tell use to restart app
        self.displayOkAlert(title: L("settings.change-language.change.title"),
                          message: L("settings.change-language.change.message"),
                          action: L("action.ok")) { [weak self] in
                            ServiceManager.shared.setLanguage(appLanguage)
                            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension LanguageSelectorViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: languageCellId, for: indexPath)
        let appLanguage = dataSource[indexPath.row]
        cell.textLabel?.text = appLanguage.selectorTitle()
        cell.accessoryType = (selectedIndexPath == indexPath ? .checkmark : .none)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedIndexPath = selectedIndexPath {
            let selectedCell = tableView.cellForRow(at: selectedIndexPath)
            selectedCell?.accessoryType = .none
        }
        
        selectedIndexPath = indexPath
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
}
