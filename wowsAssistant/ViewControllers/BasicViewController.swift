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
        view.backgroundColor = UIColor.WowsTheme.gradientCenter
        addBackgroundImage()
        
    }
    
    private func addBackgroundImage() {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "blue-steel-background"))
        imgV.contentMode = .scaleToFill
        imgV.clipsToBounds = true
        view.addSubview(imgV)
        imgV.anchor(view.leadingAnchor, view.topAnchor, view.trailingAnchor, view.safeAreaLayoutGuide.bottomAnchor)
    }
    
}
