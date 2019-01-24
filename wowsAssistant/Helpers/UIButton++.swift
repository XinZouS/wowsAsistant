//
//  UIButton++.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setupAppearance(_ backgroundColor: UIColor? = nil, title: String, textColor: UIColor, fontSize: CGFloat) {
        if let bgClr = backgroundColor {
            self.backgroundColor = bgClr
        }
        setBtnTitle(title, textColor, fontSize)
    }
        
    func setupGradient(_ clrTop: UIColor, _ clrBottom: UIColor, title: String, textColor: UIColor, fontSize: CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.locations = [0.0, 1.0]
        gradient.colors = [clrTop, clrBottom]
        self.layer.insertSublayer(gradient, at: 0)
        
        setBtnTitle(title, textColor, fontSize)
    }
    
    private func setBtnTitle(_ t: String, _ tClr: UIColor, _ font: CGFloat) {
        let atts:[NSAttributedString.Key:Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: font),
            NSAttributedString.Key.foregroundColor: tClr]
        let attribStr = NSAttributedString(string: t, attributes: atts)
        
        self.setAttributedTitle(attribStr, for: .normal)
    }
    
}
