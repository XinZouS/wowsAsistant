//
//  ShipDetailTableCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/31/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ShipDetailTableCell: UITableViewCell {
    
    var pair: Pair?
    
    let nameLabel = UILabel()
    let valueLabel = UILabel()
    private let fontSize: CGFloat = 14
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.WowsTheme.gradientBlueLight
        setupLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateLabels()
    }
    
    private func setupLabels() {
        let margin: CGFloat = 10
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
        nameLabel.font = UIFont.systemFont(ofSize: fontSize)
        addSubview(nameLabel)
        nameLabel.addConstraint(leftAnchor, nil, nil, nil, left: margin, top: 0, right: 0, bottom: 0)
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        valueLabel.textColor = .white
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 2
        valueLabel.font = UIFont.systemFont(ofSize: fontSize)
        addSubview(valueLabel)
        valueLabel.addConstraint(nameLabel.rightAnchor, nil, rightAnchor, nil, left: margin, top: 0, right: margin, bottom: 0)
        valueLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    }
    
    func updateLabels() {
        if let p = pair {
            nameLabel.text = p.title
            valueLabel.text = "\(p.value)"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pair = nil
    }
    
}
