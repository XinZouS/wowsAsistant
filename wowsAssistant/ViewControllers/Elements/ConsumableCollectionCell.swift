//
//  ConsumableCollectionCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ConsumableCollectionCell: ItemBaseCollectionCell {
    
    var consumable: Consumable? {
        didSet {
            updateConsumableInfo()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func updateConsumableInfo() {
        guard let cons = consumable else { return }
        
        if let url = URL(string: cons.image) {
            iconImageView.af_setImage(withURL: url)
        }
        let titleAtts = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        let description = NSMutableAttributedString(string: cons.name, attributes: titleAtts)
        
        let profileAtts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                           NSAttributedString.Key.foregroundColor: UIColor.white]
        for profile in cons.profiles {
            let profileStr = NSAttributedString(string: "\n\(profile.description)", attributes: profileAtts)
            description.append(profileStr)
        }
        
        let detailAtts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        let detail = NSMutableAttributedString(string: "\n\(cons.description)", attributes: detailAtts)
        description.append(detail)
        
        if cons.priceGold > 0 {
            priceImageView.image = #imageLiteral(resourceName: "coins_doubloon")
            priceLabel.text = "\(cons.priceGold)"
        } else {
            priceImageView.image = #imageLiteral(resourceName: "coins_silver")
            priceLabel.text = "\(cons.priceCredit)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
