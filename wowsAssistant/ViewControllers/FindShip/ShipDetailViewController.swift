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
    fileprivate let shipImageView = UIImageView()
    fileprivate let contourImageViewH: CGFloat = 60
    fileprivate let contourImageView = UIImageView()
    // collectionView
    fileprivate let moduleCellId = "moduleCellId"
    fileprivate let moduleCollectionViewH: CGFloat = 160
    fileprivate let moduleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    fileprivate let moduleUpgradeSlotsCount: Int = 6
    // tableView
    fileprivate var tableDataSource: [ShipViewModel] = []
    fileprivate let tableCellId = "tableCellId"
    fileprivate let tableView = UITableView()
    
    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTableViewDataSource()
        setupTitleViews()
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
    
    private func setupTitleViews() {
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
        
        shipImageView.contentMode = .scaleAspectFill
        view.addSubview(shipImageView)
        shipImageView.addConstraint(flagBackgroundImageView.leftAnchor, flagBackgroundImageView.topAnchor, flagBackgroundImageView.rightAnchor, flagBackgroundImageView.bottomAnchor)
        
        let contourBottomMargin: CGFloat = 6
        contourImageView.contentMode = .scaleAspectFit
        contourImageView.backgroundColor = UIColor.WowsTheme.gradientBlueLight
        view.addSubview(contourImageView)
        contourImageView.addConstraint(vs.leftAnchor, flagBackgroundImageView.bottomAnchor, vs.rightAnchor, nil, left: 0, top: 0, right: 0, bottom: contourBottomMargin, width: 0, height: contourImageViewH - contourBottomMargin)
        
        tableViewOffsetY = flagBackgroundImageViewH + contourImageViewH + moduleCollectionViewH
        tableView.contentInset = UIEdgeInsets(top: tableViewOffsetY, left: 0, bottom: 0, right: 0)
        tableView.setContentOffset(CGPoint(x: 0, y: -tableViewOffsetY), animated: false)
        
        moduleCollectionView.backgroundColor = .clear
        moduleCollectionView.isScrollEnabled = false
        moduleCollectionView.register(ModuleCollectionCell.self, forCellWithReuseIdentifier: moduleCellId)
        moduleCollectionView.dataSource = self
        moduleCollectionView.delegate = self
        view.addSubview(moduleCollectionView)
        moduleCollectionView.addConstraint(vs.leftAnchor, contourImageView.bottomAnchor, vs.rightAnchor, nil, left: 0, top: contourBottomMargin, right: 0, bottom: 0, width: 0, height: moduleCollectionViewH)
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
            contourImageView.af_setImage(withURL: url)
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
        return 3 //moduleUpgradeSlotsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
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
        let w: CGFloat = (view.frame.width - 100) / CGFloat(moduleUpgradeSlotsCount)
        return CGSize(width: w, height: w)
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
        header.pair = tableDataSource[section].sectionPair
        header.updateUI()
        return header
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


