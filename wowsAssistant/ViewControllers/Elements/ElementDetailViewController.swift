//
//  ElementDetailViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit


class ElementDetailViewController: UIViewController {
    
    var elements: [ElementViewModel] = []
    
    let cellId = "elementCellId"
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(ElementDetailCollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
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
