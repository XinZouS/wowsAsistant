//
//  CommanderSkillsViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/19/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class CommanderSkillsViewController: BasicViewController {
    
    fileprivate var isAllowNextPage = true
    fileprivate let itemLimitOfEachPage = 36
    
    fileprivate let cellId = "skillCellId"
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    /// sorted by .tier, shows type name
    fileprivate var skills: [CommanderSkill] = []
    
    
    // MARK: - View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupCollectionView() {
        let vs = self.view.safeAreaLayoutGuide
        view.addSubview(collectionView)
        collectionView.addConstraint(vs.leftAnchor, vs.topAnchor, vs.rightAnchor, vs.bottomAnchor, left: 0, top: 0, right: 0, bottom: 0)
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

