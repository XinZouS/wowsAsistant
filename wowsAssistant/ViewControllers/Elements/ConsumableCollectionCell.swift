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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        consumable = nil
        priceLabel.text = nil
        iconImageView.image = nil
        textView.attributedText = nil
    }
    
    private func updateConsumableInfo() {
        guard let cons = consumable else { return }
        
        if let url = URL(string: cons.image) {
            iconImageView.af_setImage(withURL: url)
        }
        let titleAtts = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.WowsTheme.textCyan]
        let description = NSMutableAttributedString(string: cons.name, attributes: titleAtts)
        
        for (i,profile) in cons.profiles.enumerated() {
            let textColor = i % 2 == 0 ? UIColor.white : UIColor.lightGray
            let profileAtts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                               NSAttributedString.Key.foregroundColor: textColor]
            let profileStr = NSAttributedString(string: "\n\(profile.description)", attributes: profileAtts)
            description.append(profileStr)
        }
        
        let detailAtts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                    NSAttributedString.Key.foregroundColor: UIColor.white]
        let detail = NSMutableAttributedString(string: "\n\(cons.description)", attributes: detailAtts)
        description.append(detail)
        
        textView.attributedText = description
        
        let initSize = CGSize(width: textView.bounds.width, height: 1000) // height is init with enough value to cover max probability
        let estimateSize = description.boundingRect(with: initSize, options: .usesFontLeading, context: nil)
        let isTextFull = estimateSize.height > textView.bounds.height
        textView.isUserInteractionEnabled = isTextFull
        
        if cons.priceGold > 0 {
            priceImageView.image = #imageLiteral(resourceName: "coins_doubloon")
            priceLabel.text = "\(cons.priceGold.getFormattedString())"
        } else {
            priceImageView.image = #imageLiteral(resourceName: "coins_silver")
            priceLabel.text = "\(cons.priceCredit.getFormattedString())"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
