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
    
    var serverRelam = ServerRealm.na
    var shipType = ShipType.AC
    var shipTier: Int?
    
    var searchShips: [ShipInfo] = []
    var myFavoriteShips: [ShipInfo] = []
    
    let rowTypeHeigh: CGFloat = 50
    let stackViewTrail: CGFloat = 10
    var stackView: UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchShipTypeBar()
        
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
        print(item)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            let loc = touch.location(in: stackView)
            if let sv = stackView, loc.x > 0, loc.y < rowTypeHeigh { // in ShipType stackView
                let item = Int(loc.x) / Int((sv.frame.width + stackViewTrail) / 5) // 5 ship types, constant
                didSelectShipType(item)
            }
        }
    }
    
    
}
