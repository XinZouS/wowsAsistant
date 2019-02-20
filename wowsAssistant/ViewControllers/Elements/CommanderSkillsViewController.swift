//
//  CommanderSkillsViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/19/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class CommanderSkillsViewController: ElementDetailViewController {
    
    /// Upgrades, Flags, Camouflages, Ship camouflages, Permanent
    let commanderSkillTypes: [String] = ["Modernization", "Flags", "Camouflage", "Skin", "Permoflage"]
    var currTypeIndex = 0
    
    
}

extension CommanderSkillsViewController: ElementDetailViewDataSourceDelegate {
    
    func loadDataSource() {
        if currTypeIndex >= commanderSkillTypes.count { return }
        let currType = commanderSkillTypes[currTypeIndex]
        ApiServers.shared.getCommanderSkills(type: currType) { [weak self] (commanderSkills) in
            var elements: [ElementContent] = []
            for skill in commanderSkills {
                let description = "\()\n\()\n\()"
                elements.append(ElementContent(urlStr: skill.icon, description: description))
            }
            let viewModels = [ElementViewModel(title: currType, content: elements)]
            self?.elementDataSourceDidUpdate(viewModels)
        }
    }
}
