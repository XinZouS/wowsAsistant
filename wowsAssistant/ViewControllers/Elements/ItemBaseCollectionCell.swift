//
//  ItemBaseCollectionCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/20/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ItemBaseCollectionCell: UICollectionViewCell {
    
    internal let iconImageView = UIImageView()
    internal let priceImageView = UIImageView()
    internal let priceLabel = UILabel()
    internal let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        let space: CGFloat = 10
        let margin: CGFloat = 20
        let iconSize: CGFloat = 60
        
        iconImageView.contentMode = .scaleAspectFit
        addSubview(iconImageView)
        iconImageView.addConstraint(leftAnchor, topAnchor, nil, nil, left: margin, top: margin, right: 0, bottom: 0, width: iconSize, height: iconSize)
        
        let priceImgSize: CGFloat = 14
        priceImageView.contentMode = .scaleAspectFit
        addSubview(priceImageView)
        priceImageView.addConstraint(leftAnchor, iconImageView.bottomAnchor, nil, nil, left: space, top: space, right: 0, bottom: 0, width: priceImgSize, height: priceImgSize)
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        priceLabel.textColor = .white
        addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.leftAnchor.constraint(equalTo: priceImageView.rightAnchor, constant: 5).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: priceImageView.centerYAnchor).isActive = true
        
        textView.backgroundColor = .clear
        textView.isUserInteractionEnabled = false
        addSubview(textView)
        textView.addConstraint(iconImageView.rightAnchor, topAnchor, rightAnchor, bottomAnchor, left: space, top: space, right: space, bottom: space)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
