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
    
    let rowTypeHeigh: CGFloat = 50
    let rowFlagHeigh: CGFloat = 43
    let rowFlagTrail: CGFloat = 90
    let rowTierHeigh: CGFloat = 40
    
    let stackViewTrail: CGFloat = 10
    var stackView: UIStackView?
    var flagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var tierCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let flagCellId = "flagCellId"
    let tierCellId = "tierCellId"
    let resultCellId = "resultCellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchShipTypeBar()
        setupCollectionViews()
        setupFindButton()
    }
    
    private func setupSearchShipTypeBar() {
        let l = UILabel() // serverRelamLabel
        l.textColor = .white
        l.textAlignment = .center
        l.text = serverRelam.descriptionString()
        view.addSubview(l)
        let vs = view.safeAreaLayoutGuide
        l.anchor(vs.leadingAnchor, vs.topAnchor, nil, nil, lead: 0, top: 0, width: 66, height: rowTypeHeigh)
        
        let serverRelamButton = UIButton()
        serverRelamButton.addTarget(self, action: #selector(serverRelamButtonTapped), for: .touchUpInside)
        view.addSubview(serverRelamButton)
        serverRelamButton.anchor(l.leadingAnchor, l.topAnchor, l.trailingAnchor, l.bottomAnchor)
        
        setupShipTypeIconStackView(relamLabel: l)
    }
    
    @objc private func serverRelamButtonTapped() {
        print("serverRelamLabel button tapped!!")
    }
    
    private func setupShipTypeIconStackView(relamLabel: UILabel) {
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
        stackView!.anchor(relamLabel.trailingAnchor, vs.topAnchor, vs.trailingAnchor, nil, lead: 10, trail: stackViewTrail, height: rowTypeHeigh)
    }
    
    private func didSelectShipType(_ item: Int) {
        switch item {
        case 0:
            shipType = .AC
        case 1:
            shipType = .BB
        case 2:
            shipType = .CR
        case 3:
            shipType = .DD
        default:
            shipType = .SB
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
        
        if let touch = touches.first {
            let loc = touch.location(in: stackView)
            if let sv = stackView, loc.x > 0, loc.y < rowTypeHeigh { // in ShipType stackView
                let item = Int(loc.x) / (Int(sv.frame.width + stackViewTrail) / ShipType.allCases.count) // 5 ship types, constant
                didSelectShipType(item)
            }
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
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

extension FindShipViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == flagCollectionView {
            return CGSize(width: rowFlagHeigh * 1.46, height: rowFlagHeigh)
        }
        if collectionView == tierCollectionView {
            return CGSize(width: rowTierHeigh * 1.2, height: rowTierHeigh)
        }
        if collectionView == resultCollectionView {
            let w = view.frame.width / 2 - 10
            return CGSize(width: w, height: 100)
        }
        return .zero
    }
    
}
