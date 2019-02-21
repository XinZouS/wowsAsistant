//
//  CommanderSkillsViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/19/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class CommanderSkillsViewController: ItemBaseViewController {
    
    fileprivate var isAllowNextPage = true
    fileprivate let itemLimitOfEachPage = 36
    
    fileprivate let cellId = "skillCellId"
    
    /// sorted by .tier, shows type name
    fileprivate var skills: [CommanderSkill] = []
    
    
    override func setupTableView() {
        super.setupTableView()
        tableView.register(CommanderSkillCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    private func loadDataSource() {
        ApiServers.shared.getCommanderSkills { [weak self] (commanderSkills) in
            self?.skills.append(contentsOf: commanderSkills)
            self?.updateCollectionView()
        }
    }
    
    private func updateCollectionView() {
        skills.sort { (a, b) -> Bool in
            return a.tier < b.tier
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}


extension CommanderSkillsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CommanderSkillCell {
            if indexPath.row < skills.count {
                cell.skill = skills[indexPath.row]
            }
            return cell
        }
        return UITableViewCell(frame: .zero)
    }
    
}

extension CommanderSkillsViewController: UITableViewDelegate {
    
    
}

