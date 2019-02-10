//
//  ShipDetailHeaderView.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/10/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

protocol ShipDetailHeaderDelegate: class {
    func expandSection(_ isExpand: Bool)
}

class ShipDetailHeaderView: UIView {
    
    var pair: Pair?
    var isExpanded = true
    weak var delegate: ShipDetailHeaderDelegate?
    
    private let nameLabel = UILabel()
    private let valueLabel = UILabel()
    private let valueBar = UIView()
    private var valueBarWidthConstraint: NSLayoutConstraint?
    private let arrowImageView = UIImageView()
    private let arrowButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        valueBar.backgroundColor = UIColor.WowsTheme.lineCyan
        addSubview(valueBar)
        valueBar.addConstraint(leftAnchor, topAnchor, nil, bottomAnchor, left: 0, top: 0, right: 0, bottom: 0)
        valueBarWidthConstraint = valueBar.widthAnchor.constraint(equalToConstant: 0)
        valueBarWidthConstraint?.isActive = true
        
        let margin: CGFloat = 10
        arrowImageView.contentMode = .scaleAspectFit
        addSubview(arrowImageView)
        arrowImageView.addConstraint(leftAnchor, topAnchor, nil, bottomAnchor, left: margin, top: 0, right: 0, bottom: 0, width: 40, height: 0)
        
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        addSubview(nameLabel)
        nameLabel.addConstraint(arrowImageView.rightAnchor, nil, nil, nil, left: margin, top: 0, right: 0, bottom: 0)
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        valueLabel.textColor = .white
        valueLabel.textAlignment = .right
        addSubview(valueLabel)
        valueLabel.addConstraint(nameLabel.rightAnchor, nil, rightAnchor, nil, left: margin, top: 0, right: margin, bottom: 0)
        valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        arrowButton.addTarget(self, action: #selector(arrowButtonTapped), for: .touchUpInside)
    }
    
    func updateUI() {
        guard let p = pair else { return }
        nameLabel.text = p.title
        valueLabel.text = "\(p.value)"
    }
    
    @objc private func arrowButtonTapped() {
        self.isExpanded = !isExpanded
        delegate?.expandSection(isExpanded)
        // TODO: animation for expand
    }
    
    
}

