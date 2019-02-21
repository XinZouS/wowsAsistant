//
//  CommanderSkillCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/20/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class CommanderSkillCell: ItemBaseCell {
    
    var skill: CommanderSkill? {
        didSet {
            updateInfo()
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPriceUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPriceUI() {
        
    }
    
    private func updateInfo() {
        guard let skill = skill else { return }
        if let url = URL(string: skill.icon) {
            iconImageView.af_setImage(withURL: url)
        }
        let description = NSMutableAttributedString(string: skill.name, attributes: titleAttributes)
        
        let typeAtts = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        let type = NSMutableAttributedString(string: "\nT\(skill.tier): \(skill.typeName)", attributes: typeAtts)
        description.append(type)
        
        let detailAtts = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        let detail = NSMutableAttributedString(string: "\n\(skill.getPerksDescription())", attributes: detailAtts)
        description.append(detail)
        
        descriptionLabel.attributedText = description
    }
    
    
}

