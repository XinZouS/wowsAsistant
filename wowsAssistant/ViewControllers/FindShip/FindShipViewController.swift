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
    
    var shipNations = ShipNation.allCases
    var shipTiers = [10,9,8,7,6,5,4,3,2,1]
    
    var searchShips: [ShipInfo] = []
    var myFavoriteShips: [ShipInfo] = []
    
    // MARK: - UI contents
    let rowTypeHeigh: CGFloat = 50
    let rowFlagHeigh: CGFloat = 40
    let rowFlagTrail: CGFloat = 90
    let rowTierHeigh: CGFloat = 40
    let resultInterItemSpace: CGFloat = 10
    let stackViewRightSpacing: CGFloat = 10
    
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
    let resultCellId = "resultCellId"
    
    // MARK: - View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchShipTypeBar()
        setupShipTypeIconStackView()
        setupCollectionViews()
        setupFindButton()
    }
    
    private func setupSearchShipTypeBar() {
        serverRelamLabel.textColor = .white
        serverRelamLabel.textAlignment = .center
        serverRelamLabel.text = serverRelam.descriptionString()
        view.addSubview(serverRelamLabel)
        let vs = view.safeAreaLayoutGuide
        serverRelamLabel.anchor(vs.leadingAnchor, vs.topAnchor, nil, nil, lead: 0, top: 0, width: 66, height: rowTypeHeigh)
        
        let serverRelamButton = UIButton()
        serverRelamButton.addTarget(self, action: #selector(serverRelamButtonTapped), for: .touchUpInside)
        view.addSubview(serverRelamButton)
        serverRelamButton.anchor(serverRelamLabel.leadingAnchor, serverRelamLabel.topAnchor, serverRelamLabel.trailingAnchor, serverRelamLabel.bottomAnchor)
    }
    
    @objc private func serverRelamButtonTapped() {
        print("serverRelamLabel button tapped!!")
    }
    
    private func setupShipTypeIconStackView() {
        let types: [ShipType] = [.AC, .BB, .CR, .DD, .SB]
        let icons: [UIImageView] = types.map { (sType) -> UIImageView in
            let urlStr =  sType.iconImageUrl()
            let v = UIImageView()
            v.contentMode = .scaleAspectFit
            v.widthAnchor.constraint(equalToConstant: 40).isActive = true
            if let url = URL(string: urlStr) {
                v.af_setImage(withURL: url)
            }
            return v
        }
        stackView = UIStackView(arrangedSubviews: icons)
        stackView!.isUserInteractionEnabled = true
        stackView!.distribution = .equalSpacing
        stackView!.axis = .horizontal
        view.addSubview(stackView!)
        let vs = view.safeAreaLayoutGuide
        stackView!.addConstraint(serverRelamLabel.rightAnchor, vs.topAnchor, vs.rightAnchor, nil, left: stackViewRightSpacing, right: stackViewRightSpacing, height: rowTypeHeigh)
        
        let imgH: CGFloat = 45
        shipTypeSelectionImageView.image = #imageLiteral(resourceName: "selectionCircle_cyan_s")
        shipTypeSelectionImageView.contentMode = .scaleAspectFit
        shipTypeSelectionImageView.isHidden = true
        view.insertSubview(shipTypeSelectionImageView, belowSubview: stackView!)
        shipTypeSelectionImageView.addConstraint(width: imgH, height: imgH)
        shipTypeSelectionImageView.centerYAnchor.constraint(equalTo: stackView!.centerYAnchor, constant: -2).isActive = true
        shipTypeSelectionImageViewLeadingConstraint = shipTypeSelectionImageView.leftAnchor.constraint(equalTo: stackView!.leftAnchor)
        shipTypeSelectionImageViewLeadingConstraint?.isActive = true
    }
    
    private func didSelectShipType(_ item: Int, _ cellWidth: CGFloat) {
        let delta = CGFloat(item) * cellWidth
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
        findBtn.setupGradient(UIColor.WowsTheme.buttonRedTop, UIColor.WowsTheme.buttonRedBot, btnFrame, title: L("action.search"), textColor: .white, fontSize: 18, isBold: true)
        findBtn.addTarget(self, action: #selector(searchShip), for: .touchUpInside)
    }
    
    @objc private func searchShip() {
        
        // TODO: set pagination limit and pageNum
        
        ApiServers.shared.getShipsList(realm: serverRelam, shipType: shipType, nation: shipNation, limit: 20, pageNum: 1) { [weak self] (shipInfos) in
            if let infos = shipInfos {
                self?.searchShips = infos
                DispatchQueue.main.async {
                    self?.resultCollectionView.reloadData()
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        
        let loc = touch.location(in: stackView)
        if let sv = stackView, loc.x > 0, loc.y < rowTypeHeigh { // in ShipType stackView
            let cellWidth = (sv.frame.width + stackViewRightSpacing * 2) / CGFloat(ShipType.allCases.count)
            let item = Int(loc.x) / Int(cellWidth) // 5 ship types, constant
            didSelectShipType(item, cellWidth)
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
                    c.flag = shipNations[indexPath.item]
                }
                return c
            }
        }
        if collectionView == tierCollectionView {
            if let c = tierCollectionView.dequeueReusableCell(withReuseIdentifier: tierCellId, for: indexPath) as? TierCell {
                if indexPath.item < shipTiers.count {
                    c.tier = shipTiers[indexPath.item]
                }
                return c
            }
        }
        if collectionView == resultCollectionView {
            if let c = resultCollectionView.dequeueReusableCell(withReuseIdentifier: resultCellId, for: indexPath) as? ResultCell {
                if indexPath.section == 0 {
                    if indexPath.item < searchShips.count {
                        c.shipInfo = searchShips[indexPath.item]
                    }
                } else {
                    if indexPath.item < myFavoriteShips.count {
                        c.shipInfo = myFavoriteShips[indexPath.item]
                    }
                }
                return c
            }
        }
        return UICollectionViewCell()
    }
}

extension FindShipViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == flagCollectionView, indexPath.item < shipNations.count {
            shipNation = shipNations[indexPath.item]
            if let c = flagCollectionView.cellForItem(at: indexPath) as? FlagCell {
                c.backgroundColor = UIColor.WowsTheme.lineCyan
            }
        }
        if collectionView == tierCollectionView, indexPath.item < shipTiers.count {
            shipTier = shipTiers[indexPath.item]
            if let c = tierCollectionView.cellForItem(at: indexPath) as? TierCell {
                c.rotateSelectionAnimation()
            }
        }
        if collectionView == resultCollectionView {
            if indexPath.section == 0, indexPath.item < searchShips.count {
                // go to ship detail vc
            } else
            if indexPath.section == 1, indexPath.item < myFavoriteShips.count {
                // also go
            }
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
                c.rotateSelectionStop()
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
    
}
