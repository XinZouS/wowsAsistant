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
    
    override func setupCollectionView() {
        super.setupCollectionView()
        collectionView.register(ConsumableCollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
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
                self?.collectionView.reloadData()
            }
        }
    }
    
}

extension ConsumablesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return consumableViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < consumableViewModels.count {
            return consumableViewModels[section].consumables.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ConsumableCollectionCell {
            if indexPath.section < consumableViewModels.count, indexPath.item < consumableViewModels[indexPath.section].consumables.count {
                cell.consumable = consumableViewModels[indexPath.section].consumables[indexPath.item]
            }
            return cell
        }
        return UICollectionViewCell(frame: .zero)
    }
    
    
    
    
}

extension ConsumablesViewController: UICollectionViewDelegate {
    
    
}

extension ConsumablesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = self.view.bounds.width
        return CGSize(width: w, height: 80)
    }
    
}
