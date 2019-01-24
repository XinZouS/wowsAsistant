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
    var shipTier: Int?
    
    var searchShips: [ShipInfo] = []
    var myFavoriteShips: [ShipInfo] = []
    
    let rowTypeHeigh: CGFloat = 50
    let stackViewTrail: CGFloat = 10
    var stackView: UIStackView?
    var flagCollectionView = UICollectionView()
    var tierCollectionView = UICollectionView()
    var resultCollectionView = UICollectionView()
    
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
        
        let vs = view.safeAreaLayoutGuide
        view.addSubview(flagCollectionView)
        flagCollectionView.anchor(vs.leadingAnchor, stackView?.bottomAnchor, vs.trailingAnchor, nil, trail: 80, height: 60)
        view.addSubview(tierCollectionView)
        tierCollectionView.anchor(vs.leadingAnchor, flagCollectionView.bottomAnchor, flagCollectionView.trailingAnchor, nil, height: 40)
        view.addSubview(resultCollectionView)
        resultCollectionView.anchor(vs.leadingAnchor, tierCollectionView.bottomAnchor, vs.trailingAnchor, vs.bottomAnchor)
    }
    
    private func setupFindButton() {
        let findBtn = UIButton()
        findBtn.setupGradient(UIColor.WowsTheme.buttonRedTop, UIColor.WowsTheme.buttonRedBot, title: L("action.search"), textColor: .white, fontSize: 18)
        findBtn.anchor(flagCollectionView.trailingAnchor, flagCollectionView.topAnchor, view.safeAreaLayoutGuide.trailingAnchor, tierCollectionView.bottomAnchor, lead: 0, top: 0, trail: 0, bottom: 0)
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
