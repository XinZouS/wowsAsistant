//
//  ItemBaseCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/20/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ItemBaseCell: UITableViewCell {
    
    internal let iconImageView = UIImageView()
    internal let priceImageView = UIImageView()
    internal let priceLabel = UILabel()
    internal let descriptionLabel = UILabel()
    
    /// margin size on X axis
    internal let marginX: CGFloat = 20
    internal let iconSize: CGFloat = 60
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupUI()
    }
    
    private func setupUI() {
        let space: CGFloat = 10
        
        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)
        iconImageView.addConstraint(leftAnchor, topAnchor, nil, nil, left: marginX, top: marginX, right: 0, bottom: 0, width: iconSize, height: iconSize)
        
        let priceImgSize: CGFloat = 14
        priceImageView.contentMode = .scaleAspectFit
        addSubview(priceImageView)
        priceImageView.addConstraint(leftAnchor, iconImageView.bottomAnchor, nil, nil, left: space, top: 0, right: 0, bottom: 0, width: priceImgSize, height: priceImgSize)
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.textColor = .white
        addSubview(priceLabel)
        priceLabel.addConstraint(priceImageView.rightAnchor, nil, iconImageView.rightAnchor, nil, left: 5, top: 0, right: -6, bottom: 0, width: 0, height: priceImgSize)
        priceLabel.centerYAnchor.constraint(equalTo: priceImageView.centerYAnchor).isActive = true
//        priceLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: marginX).isActive = true
        
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
        descriptionLabel.addConstraint(iconImageView.rightAnchor, iconImageView.topAnchor, rightAnchor, bottomAnchor, left: space, top: 0, right: space, bottom: marginX)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
