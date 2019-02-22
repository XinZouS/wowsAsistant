//
//  FindShipViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/22/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit
import AlamofireImage

class FindShipViewController: BasicViewController {
    
    var serverRelam: ServerRealm = UserDefaults.getServerRelam()
    var shipType: ShipType?
    var shipNation: ShipNation?
    var shipTier: Int?
    
    /// TODO: , .SB]
    let shipTypes: [ShipType] = [.AC, .BB, .CR, .DD]
    var shipNations = ShipNation.allCases
    var shipTiers = [10,9,8,7,6,5,4,3,2,1]
    
    var searchShips: [ShipInfo] = []
    var myFavoriteShips: [ShipInfo] = []
    var myFavoriteShipIdSet: Set<Int> = []
    
    /// pageNumber = 0 will disable query, reset value = 1;
    var pageNumber: Int = 1
    
    // MARK: - UI contents
    let rowTypeHeigh: CGFloat = 50
    let rowFlagHeigh: CGFloat = 40
    let rowFlagTrail: CGFloat = 90
    let rowTierHeigh: CGFloat = 40
    let resultInterItemSpace: CGFloat = 10
    let stackViewSideSpacing: CGFloat = 10
    let shipTypeSelectionImageSize: CGFloat = 45
    
    let serverRelamLabel = UILabel()
    var stackView: UIStackView?
    var shipTypeSelectionImageView = UIImageView()
    var shipTypeSelectionImageViewLeadingConstraint: NSLayoutConstraint?
    var flagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var tierCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Cell IDs
    let flagCellId = "flagCellId"
    let tierCellId = "tierCellId"
    let headerCellId = "headerCellId"
    let resultCellId = "resultCellId"
    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchShipTypeBar()
        setupShipTypeIconStackView()
        setupCollectionViews()
        setupFindButton()
        loadMyFavoriteShips()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.setFavoriteShips(Array(myFavoriteShipIdSet))
    }
    
    private func setupSearchShipTypeBar() {
        let w: CGFloat = 66
        serverRelamLabel.textColor = .white
        serverRelamLabel.textAlignment = .center
        serverRelamLabel.text = serverRelam.descriptionString()
        view.addSubview(serverRelamLabel)
        let vs = view.safeAreaLayoutGuide
        serverRelamLabel.anchor(vs.leadingAnchor, vs.topAnchor, nil, nil, lead: 0, top: 0, width: w, height: rowTypeHeigh)
        
        let serverRelamButton = UIButton()
        serverRelamButton.addTarget(self, action: #selector(serverRelamButtonTapped), for: .touchUpInside)
        view.addSubview(serverRelamButton)
        serverRelamButton.anchor(serverRelamLabel.leadingAnchor, serverRelamLabel.topAnchor, serverRelamLabel.trailingAnchor, serverRelamLabel.bottomAnchor)
    }
    
    @objc private func serverRelamButtonTapped() {
        let relams = ServerRealm.allCases
        let relamStrs: [String] = relams.map { (realm) -> String in
            return realm.descriptionString()
        }
        self.displayAlertActions(title: L("find-ship.confirm.title.server-relam"), actions: relamStrs, iPadReferenceView: serverRelamLabel) { [weak self] (tag) in
            if tag < relams.count {
                let newRelam = relams[tag]
                self?.serverRelam = newRelam
                self?.serverRelamLabel.text = newRelam.descriptionString()
                UserDefaults.setServerRelam(newRelam)
            }
        }
    }
    
    private func setupShipTypeIconStackView() {
        let icons: [UIView] = shipTypes.map { (sType) -> UIView in
            let containerView = UIView()
            let urlStr =  sType.iconImageUrl()
            let imgSize: CGFloat = 30
            let imgView = UIImageView()
            imgView.contentMode = .scaleAspectFit
            containerView.addSubview(imgView)
            imgView.anchorCenterIn(containerView, width: imgSize, height: imgSize)
//            imgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
//            imgView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            if let url = URL(string: urlStr) {
                imgView.af_setImage(withURL: url)
            }
            return containerView
        }
        stackView = UIStackView(arrangedSubviews: icons)
        stackView!.isUserInteractionEnabled = true
        stackView!.distribution = .fillEqually
        stackView!.axis = .horizontal
        view.addSubview(stackView!)
        let vs = view.safeAreaLayoutGuide
        stackView!.addConstraint(serverRelamLabel.rightAnchor, vs.topAnchor, vs.rightAnchor, nil, left: stackViewSideSpacing, right: stackViewSideSpacing, height: rowTypeHeigh)
        
        shipTypeSelectionImageView.image = #imageLiteral(resourceName: "selectionCircle_cyan_s")
        shipTypeSelectionImageView.contentMode = .scaleAspectFit
        shipTypeSelectionImageView.isHidden = true
        view.insertSubview(shipTypeSelectionImageView, belowSubview: stackView!)
        shipTypeSelectionImageView.addConstraint(width: shipTypeSelectionImageSize, height: shipTypeSelectionImageSize)
        shipTypeSelectionImageView.centerYAnchor.constraint(equalTo: stackView!.centerYAnchor, constant: -2).isActive = true
        shipTypeSelectionImageViewLeadingConstraint = shipTypeSelectionImageView.leftAnchor.constraint(equalTo: stackView!.leftAnchor)
        shipTypeSelectionImageViewLeadingConstraint?.isActive = true
    }
    
    private func didSelectShipType(_ item: Int, _ cellWidth: CGFloat) {
        var newType = ShipType.AC
        switch item {
        case 0:
            newType = .AC
        case 1:
            newType = .BB
        case 2:
            newType = .CR
        case 3:
            newType = .DD
        default:
            newType = .SB
        }
        
        if let oldType = self.shipType, newType == oldType {
            shipTypeSelectionAnimate(false)
            shipType = nil
        } else {
            shipType = newType
            shipTypeSelectionAnimate()
            let delta = CGFloat(item) * cellWidth + (cellWidth / 2) - (shipTypeSelectionImageSize / 2)
            shipTypeSelectionImageViewLeadingConstraint?.constant = delta
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func shipTypeSelectionAnimate(_ isStart: Bool = true) {
        if isStart {
            shipTypeSelectionImageView.rotate360Degrees(duration: 5)
            shipTypeSelectionImageView.isHidden = false
        } else {
            shipTypeSelectionImageView.layer.removeAllAnimations()
            shipTypeSelectionImageView.isHidden = true
        }
    }
    
    private func setupCollectionViews() {
        flagCollectionView.register(FlagCell.self, forCellWithReuseIdentifier: flagCellId)
        tierCollectionView.register(TierCell.self, forCellWithReuseIdentifier: tierCellId)
        let headerKind = UICollectionView.elementKindSectionHeader
        resultCollectionView.register(ResultHeaderView.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: headerCellId)
        resultCollectionView.register(ResultCell.self, forCellWithReuseIdentifier: resultCellId)
        
        flagCollectionView.delegate = self
        flagCollectionView.dataSource = self
        tierCollectionView.delegate = self
        tierCollectionView.dataSource = self
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
        if let flagCVLayout = flagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flagCVLayout.scrollDirection = .horizontal
            flagCVLayout.minimumLineSpacing = 2
        }
        if let tierCVLayout = tierCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            tierCVLayout.scrollDirection = .horizontal
            tierCVLayout.minimumLineSpacing = 5
        }
        if let rltCVLayout = resultCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            rltCVLayout.scrollDirection = .vertical
            rltCVLayout.minimumLineSpacing = resultInterItemSpace
            rltCVLayout.minimumInteritemSpacing = resultInterItemSpace
        }
        let vs = view.safeAreaLayoutGuide
        view.addSubview(flagCollectionView)
        flagCollectionView.backgroundColor = .clear
        flagCollectionView.showsHorizontalScrollIndicator = false
        flagCollectionView.anchor(vs.leadingAnchor, stackView?.bottomAnchor, vs.trailingAnchor, nil, trail: rowFlagTrail, height: rowFlagHeigh)
        view.addSubview(tierCollectionView)
        tierCollectionView.backgroundColor = .clear
        tierCollectionView.showsHorizontalScrollIndicator = false
        tierCollectionView.anchor(vs.leadingAnchor, flagCollectionView.bottomAnchor, flagCollectionView.trailingAnchor, nil, height: rowTierHeigh)
        view.addSubview(resultCollectionView)
        resultCollectionView.backgroundColor = .clear
        resultCollectionView.anchor(vs.leadingAnchor, tierCollectionView.bottomAnchor, vs.trailingAnchor, vs.bottomAnchor)
        resultCollectionView.contentInset = UIEdgeInsets(top: 0, left: resultInterItemSpace, bottom: 0, right: resultInterItemSpace)
    }
    
    private func setupFindButton() {
        let btnFrame = CGRect(x: 0, y: 0, width: rowFlagTrail, height: rowFlagHeigh + rowTierHeigh)
        let findBtn = UIButton()
        view.addSubview(findBtn)
        findBtn.anchor(flagCollectionView.trailingAnchor, flagCollectionView.topAnchor, view.safeAreaLayoutGuide.trailingAnchor, tierCollectionView.bottomAnchor, lead: 6)
        findBtn.setupGradient(UIColor.WowsTheme.buttonRedTop, UIColor.WowsTheme.buttonRedBot, bounds: btnFrame, title: L("action.search"), textColor: .white, fontSize: 18, isBold: true)
        findBtn.addTarget(self, action: #selector(searchShip), for: .touchUpInside)
    }
    
    @objc private func searchShip() {
        if pageNumber == 0 { return }
        
        searchShips.removeAll()
        
        if let selectTier = shipTier { // query by ID
            var targetInfos: [ShipInfoBasic] = ShipInfoBasicManager.shared.basics.filter { (infoBasic) -> Bool in
                return Int(infoBasic.tier) == selectTier
            }
            if let selectNation = shipNation?.rawValue {
                targetInfos = targetInfos.filter({ (infoBasic) -> Bool in
                    return infoBasic.nation == selectNation
                })
            }
            if let selectType = shipType?.rawValue {
                targetInfos = targetInfos.filter({ (infoBasic) -> Bool in
                    return infoBasic.type == selectType
                })
            }
            let ids: [Int] = targetInfos.map { (infoBasic) -> Int in
                return Int(infoBasic.ship_id)
            }
            ApiServers.shared.getShipByIdsList(ids, realm: serverRelam) { [weak self] (shipInfos) in
                if let getInfos = shipInfos {
                    self?.searchShips.append(contentsOf: getInfos)
                    self?.pageNumber = 0
                }
                self?.sortSearchShipsAndReloadData()
            }
            
        } else {
            queryByTypeAndNation()
        }
    }
    
    /// completion: hasNextPage
    private func queryByTypeAndNation() {
        if pageNumber == 0 { return }
        
        ApiServers.shared.getShipsList(realm: serverRelam, shipType: shipType, nation: shipNation, limit: 50, pageNum: pageNumber) { [weak self] (shipInfos) in
            if let infos = shipInfos {
                if infos.count == 0 {
                    self?.pageNumber = 0 // no more pages to load
                    return
                }
                self?.searchShips.append(contentsOf: infos)
                self?.sortSearchShipsAndReloadData()
                self?.pageNumber += 1
            } else {
                self?.pageNumber = 0 // no more pages
            }
        }
    }
    
    
    
    private func sortSearchShipsAndReloadData() {
        searchShips.sort() // use Comparable in ShipInfo.swift
        myFavoriteShips.sort()
        DispatchQueue.main.async {
            self.resultCollectionView.reloadData()
        }
    }
    
    private func loadMyFavoriteShips() {
        let ids = UserDefaults.getFavoriteShips()
        for id in ids {
            myFavoriteShipIdSet.insert(id)
        }
        ApiServers.shared.getShipByIdsList(ids, realm: serverRelam) { [weak self] (shipInfos) in
            if let getInfos = shipInfos {
                self?.myFavoriteShips.append(contentsOf: getInfos)
                self?.sortSearchShipsAndReloadData()
            }
        }
    }
    
}

extension FindShipViewController {
    
    /// set selection animation on top contents
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        
        let loc = touch.location(in: stackView)
        if let sv = stackView, loc.x > 0, loc.y < rowTypeHeigh { // in ShipType stackView
            let cellWidth = sv.frame.width / CGFloat(shipTypes.count)
            let item = Int(loc.x) / Int(cellWidth)
            didSelectShipType(item, cellWidth)
            pageNumber = 1
        }
        
    }
    
}


extension FindShipViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == resultCollectionView {
            return 2
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == flagCollectionView {
            return shipNations.count
        }
        if collectionView == tierCollectionView {
            return shipTiers.count
        }
        if collectionView == resultCollectionView {
            return section == 0 ? searchShips.count : myFavoriteShips.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == flagCollectionView {
            if let c = flagCollectionView.dequeueReusableCell(withReuseIdentifier: flagCellId, for: indexPath) as? FlagCell {
                if indexPath.item < shipNations.count {
                    let newFlag = shipNations[indexPath.item]
                    c.flag = newFlag
                    if let selectedFlag = shipNation {
                        c.backgroundColor = (selectedFlag == newFlag ? UIColor.WowsTheme.lineCyan : UIColor.clear)
                    }
                }
                return c
            }
        }
        if collectionView == tierCollectionView {
            if let c = tierCollectionView.dequeueReusableCell(withReuseIdentifier: tierCellId, for: indexPath) as? TierCell {
                if indexPath.item < shipTiers.count {
                    let currTier = shipTiers[indexPath.item]
                    c.tier = currTier
                    if let selectedTier = shipTier {
                        c.rotateSelectionAnimation(selectedTier == currTier)
                    }
                }
                return c
            }
        }
        if collectionView == resultCollectionView {
            if let c = resultCollectionView.dequeueReusableCell(withReuseIdentifier: resultCellId, for: indexPath) as? ResultCell {
                if indexPath.section == 0 {
                    if indexPath.item < searchShips.count {
                        let ship = searchShips[indexPath.item]
                        c.shipInfo = ship
                        c.isMarkedFavorite = myFavoriteShipIdSet.contains(ship.ship_id)
                    }
                } else {
                    if indexPath.item < myFavoriteShips.count {
                        c.shipInfo = myFavoriteShips[indexPath.item]
                        c.isMarkedFavorite = true
                    }
                }
                c.indexPath = indexPath
                c.delegate = self
                return c
            }
        }
        return UICollectionViewCell()
    }
    
    // setup Header View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == resultCollectionView {
            let headerKind = UICollectionView.elementKindSectionHeader
            if let header = resultCollectionView.dequeueReusableSupplementaryView(ofKind: headerKind, withReuseIdentifier: headerCellId, for: indexPath) as? ResultHeaderView {
                header.titleLabel.text = indexPath.section == 0 ? L("find-ship.ui.section.result") : L("find-ship.ui.section.favorite")
                return header
            }
        }
        return UICollectionReusableView(frame: .zero)
    }
    
}

extension FindShipViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == flagCollectionView, indexPath.item < shipNations.count {
            if let c = flagCollectionView.cellForItem(at: indexPath) as? FlagCell {
                pageNumber = 1
                let newNation = shipNations[indexPath.item]
                if let oldNation = shipNation, newNation == oldNation {
                    c.backgroundColor = UIColor.clear
                    shipNation = nil
                } else {
                    c.backgroundColor = UIColor.WowsTheme.lineCyan
                    shipNation = newNation
                }
            }
        }
        if collectionView == tierCollectionView, indexPath.item < shipTiers.count {
            if let c = tierCollectionView.cellForItem(at: indexPath) as? TierCell {
                pageNumber = 1
                let newTier = shipTiers[indexPath.item]
                if let oldTier = shipTier, newTier == oldTier {
                    shipTier = nil
                    c.rotateSelectionAnimation(false)
                } else {
                    shipTier = newTier
                    c.rotateSelectionAnimation()
                }
            }
        }
        if collectionView == resultCollectionView {
            let detailVC = ShipDetailViewController()
            if indexPath.section == 0, indexPath.item < searchShips.count {
                detailVC.shipInfo = searchShips[indexPath.item]
            } else
            if indexPath.section == 1, indexPath.item < myFavoriteShips.count {
                detailVC.shipInfo = myFavoriteShips[indexPath.item]
            }
            AppDelegate.shared().mainNavigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == flagCollectionView {
            if let c = flagCollectionView.cellForItem(at: indexPath) {
                c.backgroundColor = .clear
            }
        }
        if collectionView == tierCollectionView {
            if let c = tierCollectionView.cellForItem(at: indexPath) as? TierCell {
                c.rotateSelectionAnimation(false)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == resultCollectionView{
            if indexPath.section == 0, indexPath.item == searchShips.count - 1 {
                queryByTypeAndNation()
            }
        }
    }
    
}

extension FindShipViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == flagCollectionView {
            return CGSize(width: rowFlagHeigh * 1.46, height: rowFlagHeigh)
        }
        if collectionView == tierCollectionView {
            return CGSize(width: rowTierHeigh * 1.16, height: rowTierHeigh)
        }
        if collectionView == resultCollectionView {
            let w = view.frame.width / 2 - (1.6 * resultInterItemSpace) // 3: left, center, right spacing
            return CGSize(width: w, height: w * 0.78)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == resultCollectionView {
            return CGSize(width: view.bounds.width, height: 40)
        }
        return CGSize.zero
    }
}

extension FindShipViewController: ResultCellDelegate {
    
    func markShipButtonTapped(_ shipId: Int, isMarked: Bool, indexPath: IndexPath) {
        if isMarked {
            myFavoriteShipIdSet.insert(shipId)
            if indexPath.section == 0, indexPath.item < searchShips.count {
                myFavoriteShips.append(searchShips[indexPath.item])
            }
            
        } else {
            myFavoriteShipIdSet.remove(shipId)
            if indexPath.section == 0 {
                for (i, ship) in myFavoriteShips.enumerated() {
                    if ship.ship_id == shipId {
                        myFavoriteShips.remove(at: i)
                        break
                    }
                }
            } else if indexPath.section == 1, indexPath.item < myFavoriteShips.count { // remove form myfavorite list
                myFavoriteShips.remove(at: indexPath.item)
            }
        }
        sortSearchShipsAndReloadData()
    }
    
}
