//
//  ElementDetailViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

protocol ElementDetailViewDataSourceDelegate: class {
    func loadDataSource()
}

class ElementDetailViewController: BasicViewController {
    
    internal var elements: [ElementViewModel] = []
    internal var isAllowNextPage = true
    internal let itemLimitOfEachPage = 36
    
    fileprivate let cellId = "elementCellId"
    fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
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
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    internal func elementDataSourceDidUpdate(_ newDataSource: [ElementViewModel]) {
        self.elements.append(contentsOf: newDataSource)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension ElementDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < elements.count {
            return elements[section].content.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ElementDetailCollectionCell {
            if indexPath.section < elements.count, indexPath.item < elements[indexPath.section].content.count {
                let content: ElementContent = elements[indexPath.section].content[indexPath.item]
                cell.imageUrl = content.iconUrlStr
                cell.destriptionString = content.description
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
