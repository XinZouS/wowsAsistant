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
    private let selectionImageView = UIImageView()
    
    var tier: Int? {
        didSet {
            if let t = tier, t >= 0, t <= 11 {
                label.text = ShipTierString[t] ?? "-"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        selectionImageView.image = #imageLiteral(resourceName: "selectionCircle_cyan_s")
        selectionImageView.contentMode = .scaleAspectFit
        addSubview(selectionImageView)
        selectionImageView.fillSuperview()
        selectionImageView.isHidden = true
        
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        addSubview(label)
        label.fillSuperview()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rotateSelectionAnimation(false)
    }
    
    func rotateSelectionAnimation(_ isStart: Bool = true) {
        if isStart {
            selectionImageView.isHidden = false
            selectionImageView.rotate360Degrees(duration: 5)
        } else {
            selectionImageView.isHidden = true
            selectionImageView.layer.removeAllAnimations()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: -

class ResultHeaderView: UICollectionReusableView {
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupView()
    }
    
    private func setupView() {
        imageView.image = #imageLiteral(resourceName: "seprator_light")
        imageView.contentMode = .scaleToFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        titleLabel.text = "MY shipsssss"
        titleLabel.textColor = .white
        addSubview(titleLabel)
        titleLabel.addConstraint(leftAnchor, nil, nil, bottomAnchor, left: 10, top: 0, right: 0, bottom: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: -

protocol ResultCellDelegate: class {
    func markShipButtonTapped(_ shipId: Int)
}

class ResultCell: UICollectionViewCell {
    
    var shipInfo: ShipInfo? {
        didSet {
            updateShipInfoUI()
        }
    }
    
    let markFavorit = "❤️"
    let markDefault = "⚓️"
    
    var isMarkedFavorite = false {
        didSet {
            markLabel.text = isMarkedFavorite ? markFavorit : markDefault
        }
    }
    
    weak var delegate: ResultCellDelegate?
    
    let titleLabel = UILabel()
    let backgndImageView = UIImageView()
    let shipImageView = UIImageView()
    let shipTypeImageView = UIImageView()
    let shipTierLabel = UILabel()
    let markLabel = UILabel()
    let markButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1
        layer.borderColor = UIColor.WowsTheme.lineDarkBlue.cgColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.textColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.8
        addSubview(titleLabel)
        titleLabel.anchor(leadingAnchor, topAnchor, trailingAnchor, nil, lead: 5, height: 26)
        
        backgndImageView.alpha = 0.6
        backgndImageView.contentMode = .scaleToFill
        addSubview(backgndImageView)
        backgndImageView.anchor(leadingAnchor, titleLabel.bottomAnchor, trailingAnchor, bottomAnchor)
        
        shipImageView.contentMode = .scaleAspectFit
        addSubview(shipImageView)
        shipImageView.anchor(leadingAnchor, titleLabel.topAnchor, trailingAnchor, bottomAnchor, lead: 0, top: 5, trail: 0, bottom: -15)
        
        shipTypeImageView.contentMode = .scaleAspectFit
        addSubview(shipTypeImageView)
        shipTypeImageView.anchor(leadingAnchor, titleLabel.bottomAnchor, nil, nil, lead: 0, top: 0, width: 40, height: 30)
        
        shipTierLabel.textColor = .white
        shipTierLabel.font = UIFont.boldSystemFont(ofSize: 16)
        shipTierLabel.textAlignment = .left
        addSubview(shipTierLabel)
        shipTierLabel.anchor(shipTypeImageView.trailingAnchor, shipTypeImageView.topAnchor, nil, shipTypeImageView.bottomAnchor, lead: 5, top: 0, bottom: 0)
        
        markLabel.text = markDefault
        markLabel.textAlignment = .center
        markLabel.font = UIFont.systemFont(ofSize: 22)
        addSubview(markLabel)
        markLabel.anchor(nil, titleLabel.bottomAnchor, trailingAnchor, nil, lead: 0, top: 5, trail: 10, bottom: 0, width: 0, height: 0)
        
        addSubview(markButton)
        markButton.anchorCenterIn(markLabel, width: 30, height: 30)
        markButton.addTarget(self, action: #selector(markButtonTapped), for: .touchUpInside)
    }
    
    @objc private func markButtonTapped() {
        // TODO : update UI
        
        if let shipId = shipInfo?.ship_id {
            delegate?.markShipButtonTapped(shipId)
        }
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
