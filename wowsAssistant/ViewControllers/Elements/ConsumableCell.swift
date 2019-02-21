//
//  ConsumableCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ConsumableCell: ItemBaseCell {
    
    var consumable: Consumable? {
        didSet {
            updateConsumableInfo()
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        consumable = nil
        priceLabel.text = nil
        iconImageView.image = nil
        descriptionLabel.attributedText = nil
    }
    
    private func updateConsumableInfo() {
        guard let cons = consumable else { return }
        
        if let url = URL(string: cons.image) {
            iconImageView.af_setImage(withURL: url)
        }
        let titleAtts = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor: UIColor.WowsTheme.textCyan]
        let description = NSMutableAttributedString(string: cons.name, attributes: titleAtts)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 5
        let detailAtts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                          NSAttributedString.Key.foregroundColor: UIColor.white,
                          NSAttributedString.Key.paragraphStyle: paragraphStyle]
        let detail = NSMutableAttributedString(string: "\n\(cons.description)", attributes: detailAtts)
        description.append(detail)
        
        for (i,profile) in cons.profiles.enumerated() {
            let textColor = i % 2 == 1 ? UIColor.white : UIColor.lightGray
            let profileAtts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                               NSAttributedString.Key.foregroundColor: textColor]
            let profileStr = NSAttributedString(string: "\n\(profile.description)", attributes: profileAtts)
            description.append(profileStr)
        }
        
        descriptionLabel.attributedText = description // after set text, cell label will auto update height;
        
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
