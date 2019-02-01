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
    
    fileprivate var tableViewOffsetY: CGFloat = 260
    
    fileprivate let flagBackgroundImageViewH: CGFloat = 160
    fileprivate let flagBackgroundImageView = UIImageView()
    fileprivate var flagBackgroundImageViewTopConstraint: NSLayoutConstraint?
    fileprivate var flagBackgroundImageViewHeighConstraint: NSLayoutConstraint?
    fileprivate let shipImageView = UIImageView()
    fileprivate let contourImageViewH: CGFloat = 56
    fileprivate let contourImageView = UIImageView()
    // collectionView
    fileprivate let moduleCellId = "moduleCellId"
    fileprivate let moduleCollectionViewH: CGFloat = 100
    fileprivate let moduleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    fileprivate let moduleUpgradeSlotsCount: Int = 6
    // tableView
    fileprivate var tableSectionDataSource: [Pair] = []
    fileprivate var tableContentDataSource: [[Pair]] = []
    fileprivate let tableCellId = "tableCellId"
    fileprivate let tableView = UITableView()
    
    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTableViewDataSource()
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
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.fillSuperviewByConstraint()
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: tableViewOffsetY, left: 0, bottom: 0, right: 0)
        tableView.setContentOffset(CGPoint(x: 0, y: -tableViewOffsetY), animated: false)
//        tableView.separatorStyle = .none
        tableView.register(ShipDetailTableCell.self, forCellReuseIdentifier: tableCellId)
    }
    
    private func setupTitleImageViews() {
        let vs = view.safeAreaLayoutGuide
        
        flagBackgroundImageView.contentMode = .scaleToFill
        view.addSubview(flagBackgroundImageView)
        flagBackgroundImageView.addConstraint(vs.leftAnchor, nil, vs.rightAnchor, nil)
        flagBackgroundImageViewTopConstraint = flagBackgroundImageView.topAnchor.constraint(equalTo: vs.topAnchor, constant: 0)
        flagBackgroundImageViewTopConstraint?.isActive = true
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
        let vs = view.safeAreaLayoutGuide
        moduleCollectionView.register(ModuleCollectionCell.self, forCellWithReuseIdentifier: moduleCellId)
        moduleCollectionView.dataSource = self
        moduleCollectionView.delegate = self
        view.addSubview(moduleCollectionView)
        moduleCollectionView.addConstraint(vs.leftAnchor, contourImageView.bottomAnchor, vs.rightAnchor, nil, left: 0, top: 0, right: 0, bottom: 0, width: 0, height: moduleCollectionViewH)
    }
    
    private func setupTableViewDataSource() {
        //
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

// MARK: - CollectionView delegates
extension ShipDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return moduleUpgradeSlotsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section * 2 + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = moduleCollectionView.dequeueReusableCell(withReuseIdentifier: moduleCellId, for: indexPath) as? ModuleCollectionCell {
            cell.backgroundColor = .yellow
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


// MARK: - TableView delegates
extension ShipDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as? ShipDetailTableCell {
            cell.backgroundColor = UIColor.WowsTheme.gradientBlueLight
            cell.selectionStyle = .none
            
            return cell
        }
        return UITableViewCell(frame: .zero)
    }
    
    
    
}

extension ShipDetailViewController: UITableViewDelegate {
    
    
    
}


