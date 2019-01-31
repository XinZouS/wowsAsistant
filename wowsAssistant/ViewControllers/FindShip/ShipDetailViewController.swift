//
//  ShipDetailViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/31/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit


class ShipDetailViewController: BasicViewController {
    
    var shipInfo: ShipInfo?
    
    var scrollViewOffsetY: CGFloat = 260
    let scrollView = UIScrollView()
    
    let flagBackgroundImageViewH: CGFloat = 160
    let flagBackgroundImageView = UIImageView()
    var flagBackgroundImageViewHeighConstraint: NSLayoutConstraint?
    let shipImageView = UIImageView()
    let contourImageViewH: CGFloat = 56
    let contourImageView = UIImageView()
    let moduleCellId = "moduleCellId"
    let moduleCollectionViewH: CGFloat = 100
    let moduleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let moduleUpgradeSlotsCount: Int = 6
    
    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupTitleImageViews()
        setupModuleCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // pushed by mainNavigationViewController in AppDelegate
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupShipInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - UI setups
    private func setupScrollView() {
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.fillSuperviewByConstraint()
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewOffsetY), animated: false)
    }
    
    private func setupTitleImageViews() {
        let vs = view.safeAreaLayoutGuide
        
        flagBackgroundImageView.contentMode = .scaleToFill
        view.addSubview(flagBackgroundImageView)
        flagBackgroundImageView.addConstraint(vs.leftAnchor, vs.topAnchor, vs.rightAnchor, nil)
        flagBackgroundImageViewHeighConstraint = flagBackgroundImageView.heightAnchor.constraint(equalToConstant: flagBackgroundImageViewH)
        flagBackgroundImageViewHeighConstraint?.isActive = true
        
        shipImageView.contentMode = .scaleAspectFit
        flagBackgroundImageView.addSubview(shipImageView)
        shipImageView.fillSuperviewByConstraint()
        
        contourImageView.contentMode = .scaleAspectFit
        view.addSubview(contourImageView)
        contourImageView.addConstraint(vs.leftAnchor, flagBackgroundImageView.bottomAnchor, vs.rightAnchor, nil, left: 0, top: 0, right: 0, bottom: 0, width: 0, height: contourImageViewH)
    }
    
    private func setupModuleCollectionView() {
        moduleCollectionView.register(ModuleCollectionCell.self, forCellWithReuseIdentifier: moduleCellId)
        moduleCollectionView.dataSource = self
        moduleCollectionView.delegate = self
    }
    
    private func setupShipInfo() {
        guard let s = shipInfo else {
            DLog("[ERROR] ShipDetailViewController: shipInfo is nil, you should always set it before present VC!")
            return
        }
        self.title = s.name ?? ""
        flagBackgroundImageView.image = s.nationEnum.flag(isBackgroud: true)
        if let url = URL(string: s.imagesStruct?.medium ?? "") {
            shipImageView.af_setImage(withURL: url)
        }
        
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

extension ShipDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section * 2 + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = moduleCollectionView.dequeueReusableCell(withReuseIdentifier: moduleCellId, for: indexPath) as? ModuleCollectionCell {
            
            return cell
        }
        return UICollectionViewCell(frame: .zero)
    }
    
    
    
    
}

extension ShipDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w: CGFloat = (view.frame.width - 20) / CGFloat(moduleUpgradeSlotsCount)
        return CGSize(width: w, height: w)
    }
}
