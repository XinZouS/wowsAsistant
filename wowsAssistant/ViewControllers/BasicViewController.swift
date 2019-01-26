//
//  BasicViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
//        addBackgroundImage()
        addBackgroundGradient()
    }
    
    private func addBackgroundImage() {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "blue-steel-background"))
        imgV.contentMode = .scaleToFill
        imgV.clipsToBounds = true
        view.addSubview(imgV)
        imgV.anchor(view.leadingAnchor, view.topAnchor, view.trailingAnchor, view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func addBackgroundGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.colors = [UIColor.WowsTheme.gradientBlueLight.cgColor, UIColor.WowsTheme.gradientBlueDark.cgColor]
        view.layer.addSublayer(gradient)
    }
    
}
