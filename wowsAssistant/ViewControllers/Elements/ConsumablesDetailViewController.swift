//
//  ElementDetailViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ElementDetailViewController: BasicViewController {
    
    internal var isAllowNextPage = true
    internal let itemLimitOfEachPage = 36
    
    internal let cellId = "elementCellId"
    internal let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
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
        collectionView.register(ElementDetailCollectionCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
}

extension ElementDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < elements.count {
            return elements[section].contents.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ElementDetailCollectionCell {
            if indexPath.section < elements.count, indexPath.item < elements[indexPath.section].contents.count {
                let content: ElementContent = elements[indexPath.section].contents[indexPath.item]
                cell.content = content
            }
            return cell
        }
        return UICollectionViewCell(frame: .zero)
    }
    
    
    
    
}

extension ElementDetailViewController: UICollectionViewDelegate {
    
    
}

extension ElementDetailViewController: UICollectionViewDelegateFlowLayout {
    
    
    
}
