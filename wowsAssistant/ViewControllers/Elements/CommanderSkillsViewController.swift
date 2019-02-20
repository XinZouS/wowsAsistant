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
    
    
    override func setupCollectionView() {
        super.setupCollectionView()
        collectionView.register(CommanderSkillCollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
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
            self.collectionView.reloadData()
        }
    }

}

extension CommanderSkillsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CommanderSkillCollectionCell {
            if indexPath.item < skills.count {
                cell.skill = skills[indexPath.item]
            }
            return cell
        }
        return UICollectionViewCell(frame: .zero)
    }
    
    
    
    
}

extension CommanderSkillsViewController: UICollectionViewDelegate {
    
    
}

extension CommanderSkillsViewController: UICollectionViewDelegateFlowLayout {
    
    
    
}

