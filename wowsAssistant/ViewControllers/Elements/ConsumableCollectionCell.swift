//
//  ConsumableCollectionCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/17/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ConsumableCollectionCell: ItemBaseCollectionCell {
    
    var consumable: Consumable?
    
    private let margin: CGFloat = 20
    private let iconSize: CGFloat = 50
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPriceUI()
    }
    
    private func setupPriceUI() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
