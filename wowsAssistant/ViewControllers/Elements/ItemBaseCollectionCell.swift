//
//  ItemBaseCollectionCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/20/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ItemBaseCollectionCell: UICollectionViewCell {
    
    private let margin: CGFloat = 20
    private let iconSize: CGFloat = 50
    
    internal let iconImageView = UIImageView()
    internal let priceImageView = UIImageView()
    internal let priceLabel = UILabel()
    internal let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(iconImageView)
        iconImageView.addConstraint(leftAnchor, topAnchor, nil, nil, left: margin, top: margin, right: 0, bottom: 0, width: iconSize, height: iconSize)
        
        let priceImgSize: CGFloat = 15
        addSubview(priceImageView)
        priceImageView.addConstraint(iconImageView.leftAnchor, iconImageView.bottomAnchor, nil, nil, left: 0, top: 0, right: 0, bottom: 0, width: priceImgSize, height: priceImgSize)
        priceImageView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: 10).isActive = true
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.leftAnchor.constraint(equalTo: priceImageView.rightAnchor, constant: 10).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: priceImageView.centerYAnchor).isActive = true
        
        addSubview(textView)
        textView.addConstraint(iconImageView.rightAnchor, iconImageView.topAnchor, rightAnchor, bottomAnchor, left: margin, top: 0, right: margin, bottom: margin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
