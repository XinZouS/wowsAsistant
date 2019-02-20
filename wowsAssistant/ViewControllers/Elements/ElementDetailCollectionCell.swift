//
//  ElementDetailCollectionCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ElementDetailCollectionCell: UICollectionViewCell {
    
    var content: ElementContent?
    
    private let margin: CGFloat = 20
    private let iconSize: CGFloat = 50
    
    private let iconImageView = UIImageView()
    private let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    private func setupUI() {
        addSubview(iconImageView)
        iconImageView.addConstraint(leftAnchor, topAnchor, nil, nil, left: margin, top: margin, right: 0, bottom: 0, width: iconSize, height: iconSize)
        
        addSubview(textView)
        textView.addConstraint(iconImageView.rightAnchor, iconImageView.topAnchor, rightAnchor, bottomAnchor, left: margin, top: 0, right: margin, bottom: margin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
