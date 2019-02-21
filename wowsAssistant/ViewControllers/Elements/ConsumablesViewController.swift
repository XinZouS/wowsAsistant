//
//  ConsumablesViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ConsumablesViewController: ItemBaseViewController {
    
    fileprivate var isAllowNextPage = true
    fileprivate let itemLimitOfEachPage = 36
    
    fileprivate let cellId = "consumableCellId"
    
    /// Upgrades, Flags, Camouflages, Ship camouflages, Permanent
    let commanderSkillTypes: [String] = ["Modernization", "Flags", "Camouflage", "Skin", "Permoflage"]
    var currTypeIndex = 0
    
    /// sections grouped by: commanderSkillTypes
    fileprivate var consumableViewModels: [ConsumableViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.register(ConsumableCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadData() {
        if currTypeIndex >= commanderSkillTypes.count { return }
        ApiServers.shared.getConsumable(ids: nil, type: commanderSkillTypes[currTypeIndex]) { [weak self] (consumables) in
            if consumables.count == 0 { return }
            let title = consumables[0].type
            let consumablesSorted = consumables.sorted(by: <)
            let vm = ConsumableViewModel(sectionTitle: title, consumables: consumablesSorted)
            self?.consumableViewModels.append(vm)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}


extension ConsumablesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return consumableViewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < consumableViewModels.count {
            return consumableViewModels[section].consumables.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ConsumableCell {
            if indexPath.section < consumableViewModels.count, indexPath.item < consumableViewModels[indexPath.section].consumables.count {
                cell.consumable = consumableViewModels[indexPath.section].consumables[indexPath.item]
            }
            return cell
        }
        return UITableViewCell(frame: .zero)
    }
}

extension ConsumablesViewController: UITableViewDelegate {
    
    
}
