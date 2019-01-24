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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
