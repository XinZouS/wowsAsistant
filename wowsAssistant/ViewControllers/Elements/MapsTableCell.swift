//
//  MapsTableCell.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/26/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class MapsTableCell: PTTableCell {
    
    var mapModel: Map? {
        didSet {
            downloadImage()
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        self.foregroundAlpha = 0.3
    }
}

extension MapsTableCell {
    
    private func downloadImage() {
        if let urlStr = mapModel?.icon, let url = URL(string: urlStr), let name = mapModel?.name {
            self.setImage(UIImage(), title: name)
            self.bgImage?.af_setImage(withURL: url)
        }
    }
    
}
