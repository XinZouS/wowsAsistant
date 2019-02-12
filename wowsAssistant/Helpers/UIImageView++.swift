//
//  UIImageView++.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/12/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
}
