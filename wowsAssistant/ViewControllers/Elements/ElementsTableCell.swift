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
        backgroundColor = .clear
        setupView()
    }
    
    private func setupView() {
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        addSubview(itemImageView)
        itemImageView.fillSuperviewByConstraint()
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        addSubview(titleLabel)
        titleLabel.addConstraint(leftAnchor, nil, rightAnchor, nil)
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
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
