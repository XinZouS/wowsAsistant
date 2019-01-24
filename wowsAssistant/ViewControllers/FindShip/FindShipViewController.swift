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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchShipTypeBar()
        
    }
    
    private func setupSearchShipTypeBar() {
        let rowHeigh: CGFloat = 44
        let l = UILabel() // serverRelamLabel
        l.textColor = .white
        l.textAlignment = .center
        l.text = serverRelam.descriptionString()
        view.addSubview(l)
        let vs = view.safeAreaLayoutGuide
        l.anchor(vs.leadingAnchor, vs.topAnchor, nil, nil, lead: 0, top: 0, width: 66, height: rowHeigh)
        
        let serverRelamButton = UIButton()
        serverRelamButton.addTarget(self, action: #selector(serverRelamButtonTapped), for: .touchUpInside)
        view.addSubview(serverRelamButton)
        serverRelamButton.anchor(l.leadingAnchor, l.topAnchor, l.trailingAnchor, l.bottomAnchor)
        
        setupShipTypeIconStackView(rowHeigh)
    }
    
    @objc private func serverRelamButtonTapped() {
        print("serverRelamLabel button tapped!!")
    }
    
    private func setupShipTypeIconStackView(_ heigh: CGFloat) {
        let types: [ShipType] = [.AC, .BB, .CR, .DD, .SB]
        let icons: [UIImageView] = types.map { (sType) -> UIImageView in
            let urlStr =  sType.iconImageUrl()
            let v = UIImageView()
            if let url = URL(string: urlStr) {
                v.af_setImage(withURL: url)
            }
            return v
        }
        
    }
    
    
}
