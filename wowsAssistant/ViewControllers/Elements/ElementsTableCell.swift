//
//  ElementsTableCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/16/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ElementsTableCell: UITableViewCell {
    
    var content: ElementsTableContent? {
        didSet {
            setupContent()
        }
    }
    
    private let itemImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    private func setupView() {
        let margin: CGFloat = 20
        itemImageView.contentMode = .scaleAspectFill
        addSubview(itemImageView)
        itemImageView.addConstraint(leftAnchor, topAnchor, nil, bottomAnchor, left: margin, top: margin, right: 0, bottom: margin, width: 120, height: 0)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        addSubview(titleLabel)
        titleLabel.addConstraint(leftAnchor, nil, rightAnchor, nil, left: 60, top: 0, right: margin, bottom: 0)
    }
    
    private func setupContent() {
        guard let ct = content else { return }
        titleLabel.text = ct.title
        itemImageView.image = ct.image
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
