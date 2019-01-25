//
//  FindShipCollectionsCells.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class FlagCell: UICollectionViewCell {
    
    private let imgV = UIImageView()
    var flag: ShipNation? {
        didSet {
            imgV.image = flag?.flag()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgV)
        imgV.contentMode = .scaleAspectFit
        imgV.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -
class TierCell: UICollectionViewCell {
    
    private let label = UILabel()
    var tier: Int? {
        didSet {
            if let t = tier, t >= 0, t <= 11 {
                label.text = ShipTierString[t] ?? "-"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        addSubview(label)
        label.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: -
class ResultCell: UICollectionViewCell {
    
    var shipInfo: ShipInfo? {
        didSet {
            updateShipInfoUI()
        }
    }
    
    let titleLabel = UILabel()
    let backgndImageView = UIImageView()
    let shipImageView = UIImageView()
    let shipTypeImageView = UIImageView()
    let shipTierLabel = UILabel()
    let markImageView = UIImageView()
    let markButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1
        layer.borderColor = UIColor.WowsTheme.lineDarkBlue.cgColor
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.textColor = .white
        addSubview(titleLabel)
        titleLabel.anchor(leadingAnchor, topAnchor, trailingAnchor, nil, lead: 5, height: 26)
        
        backgndImageView.contentMode = .scaleToFill
        addSubview(backgndImageView)
        backgndImageView.anchor(leadingAnchor, titleLabel.bottomAnchor, trailingAnchor, bottomAnchor)
        
        shipImageView.contentMode = .scaleAspectFit
        addSubview(shipImageView)
        shipImageView.anchor(leadingAnchor, titleLabel.topAnchor, trailingAnchor, bottomAnchor, lead: 0, top: 0, trail: 0, bottom: -5)
        
        shipTypeImageView.contentMode = .scaleAspectFit
        addSubview(shipTypeImageView)
        shipTypeImageView.anchor(leadingAnchor, titleLabel.bottomAnchor, nil, nil, lead: 0, top: 0, width: 40, height: 30)
        
        shipTierLabel.textColor = .white
        shipTierLabel.font = UIFont.boldSystemFont(ofSize: 16)
        shipTierLabel.textAlignment = .left
        addSubview(shipTierLabel)
        shipTierLabel.anchor(shipTypeImageView.trailingAnchor, shipTypeImageView.topAnchor, nil, shipTypeImageView.bottomAnchor, lead: 5, top: 0, bottom: 0)
        
        markImageView.contentMode = .scaleAspectFit
        addSubview(markImageView)
        markImageView.anchor(nil, titleLabel.bottomAnchor, trailingAnchor, nil, lead: 0, top: 5, trail: 10, bottom: 0, width: 20, height: 20)
        
        addSubview(markButton)
        markButton.anchorCenterIn(markImageView, width: 30, height: 30)
        markButton.addTarget(self, action: #selector(markButtonTapped), for: .touchUpInside)
    }
    
    @objc private func markButtonTapped() {
        print("like the ship: \(shipInfo?.name)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateShipInfoUI() {
        guard let info = shipInfo else { return }
        
        titleLabel.text = info.name
        backgndImageView.image = ShipNation(rawValue: info.nation ?? "usa")?.flag(isBackgroud: true)
        
        if let smallImg = info.imagesStruct?.small, let url = URL(string: smallImg) {
            shipImageView.af_setImage(withURL: url)
        }
        if let ty = info.type, let typeUrl = ShipType(rawValue: ty)?.iconImageUrl(), let url = URL(string: typeUrl) {
            shipTypeImageView.af_setImage(withURL: url)
        }
        if let tier = info.tier, tier > 0 {
            shipTierLabel.text = ShipTierString[tier]
        }
    }
}
