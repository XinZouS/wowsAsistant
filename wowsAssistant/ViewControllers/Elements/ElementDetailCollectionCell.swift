//
//  ElementDetailCollectionCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ElementDetailCollectionCell: UICollectionViewCell {
    
    var imageUrl: String?
    var destriptionString: String?
    
    private let iconImageView = UIImageView()
    private let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
