//
//  ModuleCollectionCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/31/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ModuleCollectionCell: UICollectionViewCell {
    
    var consumable: Consumable? {
        didSet {
            loadImage()
        }
    }
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        loadImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.fillSuperviewByConstraint()
    }
    
    private func loadImage() {
        if let urlStr = consumable?.image, let url = URL(string: urlStr) {
            DispatchQueue.main.async { [weak self] in
                self?.imageView.af_setImage(withURL: url)
            }
        }
    }
}
