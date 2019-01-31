//
//  ShipDetailViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/31/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit


class ShipDetailViewController: UIViewController {
    
    var shipInfo: ShipInfo?
    
    let scrollView = UIScrollView()
    let flagBackgroundImageView = UIImageView()
    let shipImageView = UIImageView()
    let contourImageView = UIImageView()
    let moduleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.fillSuperviewByConstraint()
        
    }
    
}

extension ShipDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let deltaY = scrollView.contentOffset.y
        if deltaY < 0 {
            //
        } else {
            // hide title image
        }
    }
    
}
