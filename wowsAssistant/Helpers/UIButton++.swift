//
//  UIButton++.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setupAppearance(_ backgroundColor: UIColor? = nil, title: String, textColor: UIColor, fontSize: CGFloat, isBold: Bool = false) {
        if let bgClr = backgroundColor {
            self.backgroundColor = bgClr
        }
        setBtnTitle(title, textColor, fontSize, isBold)
    }
        
    func setupGradient(_ clrTop: UIColor, _ clrBottom: UIColor, _ bounds: CGRect = .zero, title: String, textColor: UIColor, fontSize: CGFloat = 16, isBold: Bool = false) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
//        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.colors = [clrTop.cgColor, clrBottom.cgColor]
//        self.layer.insertSublayer(gradient, at: 0)
        self.layer.addSublayer(gradient)
//        self.layer.layoutIfNeeded()
        
        setBtnTitle(title, textColor, fontSize, isBold)
    }
    
    private func setBtnTitle(_ t: String, _ tClr: UIColor, _ font: CGFloat, _ isBold: Bool = false) {
        let setFont = isBold ? UIFont.boldSystemFont(ofSize: font) : UIFont.systemFont(ofSize: font)
        let atts:[NSAttributedString.Key:Any] = [
            NSAttributedString.Key.font : setFont,
            NSAttributedString.Key.foregroundColor: tClr]
        let attribStr = NSAttributedString(string: t, attributes: atts)
        
        self.setAttributedTitle(attribStr, for: .normal)
    }
    
}
