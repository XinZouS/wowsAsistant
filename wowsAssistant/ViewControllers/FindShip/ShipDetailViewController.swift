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
    
    fileprivate var flagBackgroundImageViewH: CGFloat = 200
    fileprivate let flagBackgroundImageView = UIImageView()
    fileprivate var flagBackgroundImageViewTopConstraint: NSLayoutConstraint?
    fileprivate var flagBackgroundImageViewHeighConstraint: NSLayoutConstraint?
    // ship basic info views
    fileprivate let shipTypeImageView = UIImageView()
    fileprivate let shipTierLabel = UILabel()
    fileprivate let creditImageView = UIImageView()
    fileprivate let creditLabel = UILabel()
    fileprivate let shipImageView = UIImageView()
    fileprivate let contourImageViewH: CGFloat = 60
    fileprivate let contourImageView = UIImageView()
    // collectionView
    fileprivate var moduleDataSource: [[Consumable]] = []
    fileprivate let moduleCellId = "moduleCellId"
    fileprivate let moduleCollectionCellH: CGFloat = (140 - 20) / 3
    fileprivate let moduleCollectionViewH: CGFloat = 140
    fileprivate let moduleCollectionTopMargin: CGFloat = 6
    fileprivate let moduleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // tableView
    fileprivate var tableDataSource: [ShipViewModel] = []
    fileprivate let tableCellId = "tableCellId"
    fileprivate let tableView = UITableView()
    
    
    // MARK: - View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTableViewDataSource()
        
        setupFlagBackgroundImageView()
        setupShipImageView()
        setupContourImageView()
        
        setupModuleCollectionView()
        setupCollectionViewDataSource()
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
        let vs = view.safeAreaLayoutGuide
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.addConstraint(vs.leftAnchor, vs.topAnchor, vs.rightAnchor, vs.bottomAnchor)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(ShipDetailTableCell.self, forCellReuseIdentifier: tableCellId)
    }
    
    private func setupFlagBackgroundImageView() {
        let vs = view.safeAreaLayoutGuide
        flagBackgroundImageView.alpha = 0.56
        flagBackgroundImageView.contentMode = .scaleAspectFill
        flagBackgroundImageViewH = (426 / 694) * view.bounds.width // flag image size = 426x694
        view.addSubview(flagBackgroundImageView)
        flagBackgroundImageView.addConstraint(vs.leftAnchor, nil, vs.rightAnchor, nil)
        flagBackgroundImageViewTopConstraint = flagBackgroundImageView.topAnchor.constraint(equalTo: vs.topAnchor, constant: 0)
        flagBackgroundImageViewTopConstraint?.isActive = true
        flagBackgroundImageViewHeighConstraint = flagBackgroundImageView.heightAnchor.constraint(equalToConstant: flagBackgroundImageViewH)
        flagBackgroundImageViewHeighConstraint?.isActive = true
    }
    
    private func setupShipImageView() {
        let lineSpace: CGFloat = 10
        let margin: CGFloat = 20
        let typeImgSz: CGFloat = 36
        
        shipTypeImageView.contentMode = .scaleAspectFit
        view.addSubview(shipTypeImageView)
        shipTypeImageView.addConstraint(flagBackgroundImageView.leftAnchor, flagBackgroundImageView.topAnchor, nil, nil, left: margin, top: 0, right: 0, bottom: 0, width: typeImgSz, height: typeImgSz)
        
        shipTierLabel.font = UIFont.boldSystemFont(ofSize: 20)
        shipTierLabel.textColor = .white
        shipTierLabel.textAlignment = .left
        view.addSubview(shipTierLabel)
        shipTierLabel.addConstraint(shipTypeImageView.rightAnchor, nil, nil, nil, left: lineSpace, top: 0, right: 0, bottom: 0)
        shipTierLabel.centerYAnchor.constraint(equalTo: shipTypeImageView.centerYAnchor).isActive = true
        
        let creditImageSize: CGFloat = 15
        view.addSubview(creditImageView)
        creditImageView.addConstraint(nil, nil, flagBackgroundImageView.rightAnchor, nil, left: 0, top: lineSpace, right: margin, bottom: 0, width: creditImageSize, height: creditImageSize)
        creditImageView.centerYAnchor.constraint(equalTo: shipTypeImageView.centerYAnchor).isActive = true
        
        creditLabel.font = UIFont.boldSystemFont(ofSize: 14)
        creditLabel.textAlignment = .right
        view.addSubview(creditLabel)
        creditLabel.addConstraint(nil, nil, creditImageView.leftAnchor, nil, left: 0, top: 0, right: lineSpace, bottom: 0)
        creditLabel.centerYAnchor.constraint(equalTo: creditImageView.centerYAnchor).isActive = true
        
        shipImageView.contentMode = .scaleAspectFill
        view.addSubview(shipImageView)
        shipImageView.addConstraint(flagBackgroundImageView.leftAnchor, flagBackgroundImageView.topAnchor, flagBackgroundImageView.rightAnchor, flagBackgroundImageView.bottomAnchor)
    }
    
    private func setupContourImageView() {
        let vs = view.safeAreaLayoutGuide
        let margin: CGFloat = 6
        contourImageView.contentMode = .scaleAspectFit
        contourImageView.backgroundColor = UIColor.WowsTheme.gradientBlueLight
        view.addSubview(contourImageView)
        contourImageView.addConstraint(vs.leftAnchor, flagBackgroundImageView.bottomAnchor, vs.rightAnchor, nil, left: 0, top: 0, right: 0, bottom: margin, width: 0, height: contourImageViewH - margin)
        
        tableViewOffsetY = flagBackgroundImageViewH + contourImageViewH + moduleCollectionViewH
        tableView.contentInset = UIEdgeInsets(top: tableViewOffsetY, left: 0, bottom: 0, right: 0)
        tableView.setContentOffset(CGPoint(x: 0, y: -tableViewOffsetY), animated: false)
    }
    
    private func setupModuleCollectionView() {
        let vs = view.safeAreaLayoutGuide
        moduleCollectionView.backgroundColor = .clear
        moduleCollectionView.register(ModuleCollectionCell.self, forCellWithReuseIdentifier: moduleCellId)
        moduleCollectionView.dataSource = self
        moduleCollectionView.delegate = self
        view.addSubview(moduleCollectionView)
        moduleCollectionView.addConstraint(vs.leftAnchor, contourImageView.bottomAnchor, vs.rightAnchor, nil, left: 0, top: moduleCollectionTopMargin, right: 0, bottom: 0, width: 0, height: moduleCollectionViewH)
        if let layout = moduleCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
    }
    
    private func setupTableViewDataSource() {
        guard let ship = shipInfo?.default_profile else {
            DLog("[ERROR] ShipDetailViewController: shipInfo is nil, you should always set it before present VC!")
            return
        }
        // ❇️
        if let survivability = ship.armour {
            let model = ShipViewModel(sectionPair: survivability.getSummationDescription())
            tableDataSource.append(model)
            model.contentPairs.append(contentsOf: survivability.getNameAndValuePairs())
            if let hull = ship.hull {
                model.contentPairs.append(contentsOf: hull.getNameAndValuePairs())
            }
        }
        // ❇️
        if let artillerySum = ship.weaponry {
            let model = ShipViewModel(sectionPair: artillerySum.getArtilleryNameAndValuePair())
            tableDataSource.append(model)
            if let fireControl = ship.fire_control { // [firing range, extension]
                model.contentPairs.append(contentsOf: fireControl.getNameAndValuePairs())
            }
            if let artillery = ship.artillery { // [.., [Shell], [ArtillerySlot], ..]
                model.contentPairs.append(contentsOf: artillery.getNameAndValuePairs())
            }
            if let secondary = ship.atbas { // Atbas
                model.contentPairs.append(Pair("", ""))
                model.contentPairs.append(contentsOf: secondary.getNameAndValuePairs())
            }
        }
        // ❇️
        if let torpedo = ship.weaponry {
            let model = ShipViewModel(sectionPair: torpedo.getTorpedoesNameAndValuePair())
            tableDataSource.append(model)
            if let torps = ship.torpedoes {
                model.contentPairs.append(contentsOf: torps.getNameAndValuePairs())
            }
        }
        // ❇️
        if let aaGuns = ship.weaponry {
            let model = ShipViewModel(sectionPair: aaGuns.getAAGunsNameAndValuePair())
            tableDataSource.append(model)
            if let antiAir = ship.anti_aircraft {
                model.contentPairs.append(contentsOf: antiAir.getNameAndValuePairs())
            }
        }
        // ❇️
        if let aircraft = ship.weaponry {
            let model = ShipViewModel(sectionPair: aircraft.getAircraftNameAndValuePair())
            tableDataSource.append(model)
            if let flightControl = ship.flight_control {
                model.contentPairs.append(contentsOf: flightControl.getNameAndValuePairs())
            }
            if let flighters = ship.fighters {
                model.contentPairs.append(contentsOf: flighters.getNameAndValuePairs())
            }
            if let diveBombers = ship.dive_bomber {
                model.contentPairs.append(contentsOf: diveBombers.getNameAndValuePairs())
            }
            if let torpBombers = ship.torpedo_bomber {
                model.contentPairs.append(contentsOf: torpBombers.getNameAndValuePairs())
            }
        }
        // ❇️
        if let mobility = ship.mobility {
            let model = ShipViewModel(sectionPair: mobility.getSummationDescription())
            tableDataSource.append(model)
            if let engine = ship.engine {
                model.contentPairs.append(contentsOf: engine.getNameAndValuePairs())
            }
            model.contentPairs.append(contentsOf: mobility.getNameAndValuePairs())
        }
        // ❇️
        if let concealment = ship.concealment {
            let model = ShipViewModel(sectionPair: concealment.getSummationDescription())
            tableDataSource.append(model)
            model.contentPairs.append(contentsOf: concealment.getNameAndValuePairs())
        }
    }
    
    private func setupCollectionViewDataSource() {
        guard let consumableIds = shipInfo?.upgrades, consumableIds.count > 0 else { return }
        
        ApiServers.shared.getConsumable(ids: consumableIds) { [weak self] (consumables) in
            if var cons = consumables {
                cons.sort(by: < )
                // grouping by price for collectionView sections
                let groupDictionary = Dictionary(grouping: cons, by: { (con) -> Int in
                    return con.priceCredit
                })
                let keys: [Int] = Array(groupDictionary.keys).sorted()
                for k in keys {
                    if let dict = groupDictionary[k] {
                        self?.moduleDataSource.append(dict)
                    }
                }
                DispatchQueue.main.async {
                    self?.updateModuleCollectionView(sections: keys.count)
                }
            }
        }
    }
    
    private func updateModuleCollectionView(sections: Int) {
        let isScrollable = (UIDevice.current.userInterfaceIdiom == .phone) ? sections >= 5 : false
        moduleCollectionView.isUserInteractionEnabled = isScrollable
        let sideMargin: CGFloat = view.bounds.width / 10
        let offsetX = (view.bounds.width / 2) - (moduleCollectionCellH * CGFloat(sections / 2)) - sideMargin
        let setX = isScrollable ? sideMargin : offsetX
        moduleCollectionView.contentInset = UIEdgeInsets(top: 0, left: setX, bottom: 0, right: sideMargin)
        moduleCollectionView.reloadData()
    }
    
    
    private func setupShipInfo() {
        guard let s = shipInfo else {
            DLog("[ERROR] ShipDetailViewController: shipInfo is nil, you should always set it before present VC!")
            return
        }
        self.title = s.name ?? ""
        flagBackgroundImageView.image = s.nationEnum.flag(isBackgroud: true)
        if let url = URL(string: s.imagesStruct?.large ?? "") {
            shipImageView.af_setImage(withURL: url)
        }
        if let url = URL(string: s.imagesStruct?.contour ?? "") {
            contourImageView.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: false) { [weak self] (_) in
                self?.contourImageView.setImageColor(color: UIColor.WowsTheme.healthGreenLight)
            }
        }
        
        if let gold = shipInfo?.price_gold, gold > 0 {
            creditImageView.image = #imageLiteral(resourceName: "coins_doubloon")
            creditLabel.textColor = UIColor.WowsTheme.creditGold
            creditLabel.text = getFormattedString(gold)
        } else if let credit = shipInfo?.price_credit {
            creditImageView.image = #imageLiteral(resourceName: "coins_silver")
            creditLabel.textColor = .white
            creditLabel.text = getFormattedString(credit)
        }
        
        s.setShipTypeImageTo(shipTypeImageView)
        
        if let tier = s.tier, tier > 0 {
            shipTierLabel.text = TierString[tier]
        }
    }
    
}

extension ShipDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            let y = scrollView.contentOffset.y
            if y < -tableViewOffsetY {
                flagBackgroundImageViewTopConstraint?.constant = 0
                flagBackgroundImageViewHeighConstraint?.constant = -y - contourImageViewH - moduleCollectionViewH
            } else if y < 0 { // hide title image
                flagBackgroundImageViewTopConstraint?.constant = -(tableViewOffsetY + y)
                flagBackgroundImageViewHeighConstraint?.constant = flagBackgroundImageViewH
                tableView.contentInset = UIEdgeInsets(top: -y, left: 0, bottom: 0, right: 0)
            } else {
                flagBackgroundImageViewTopConstraint?.constant = -tableViewOffsetY
                tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
    }
    
}

// MARK: - Ship Module CollectionView delegates
extension ShipDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return moduleDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < moduleDataSource.count {
            return moduleDataSource[section].count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = moduleCollectionView.dequeueReusableCell(withReuseIdentifier: moduleCellId, for: indexPath) as? ModuleCollectionCell {
            if indexPath.section < moduleDataSource.count, indexPath.item < moduleDataSource[indexPath.section].count {
                cell.consumable = moduleDataSource[indexPath.section][indexPath.item]
            }
            return cell
        }
        return UICollectionViewCell(frame: .zero)
    }
    
    
    
    
}

extension ShipDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w: CGFloat = moduleCollectionCellH
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
}


// MARK: - TableView delegates
extension ShipDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < tableDataSource.count {
            return tableDataSource[section].isExpanded ? tableDataSource[section].contentPairs.count : 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as? ShipDetailTableCell {
            cell.selectionStyle = .none
            if indexPath.section < tableDataSource.count, indexPath.row < tableDataSource[indexPath.section].contentPairs.count {
                cell.pair = tableDataSource[indexPath.section].contentPairs[indexPath.row]
                cell.updateLabels()
            }
            return cell
        }
        return UITableViewCell(frame: .zero)
    }
    
}



extension ShipDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section >= tableDataSource.count { return nil }
        
        let header = ShipDetailHeaderView()
        header.delegate = self
        header.section = section
        header.isExpanded = tableDataSource[section].isExpanded
        header.pair = tableDataSource[section].sectionPair // pair updat MUST after expanded setup;
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}

extension ShipDetailViewController: ShipDetailHeaderDelegate {
    
    func expandSection(_ isExpand: Bool, section: Int) {
        if section >= tableDataSource.count { return }
        
        tableDataSource[section].isExpanded = isExpand
        
        var idxPathes: [IndexPath] = []
        for i in tableDataSource[section].contentPairs.indices {
            idxPathes.append(IndexPath(row: i, section: section))
        }
        if isExpand {
            tableView.insertRows(at: idxPathes, with: .fade)
        } else {
            tableView.deleteRows(at: idxPathes, with: .fade)
        }
    }
    
}


