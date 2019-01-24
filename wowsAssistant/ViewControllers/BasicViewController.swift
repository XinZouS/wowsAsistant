//
//  BasicViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.WowsTheme.gradientCenter
        addBackgroundImage()
        
    }
    
    private func addBackgroundImage() {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "blue-steel-background"))
        imgV.contentMode = .left
        imgV.clipsToBounds = true
        view.addSubview(imgV)
        imgV.anchor(view.leadingAnchor, view.topAnchor, view.trailingAnchor, view.safeAreaLayoutGuide.bottomAnchor)
        if let url = URL(string: BackgroundImageUrl.ships01.rawValue) {
            imgV.af_setImage(withURL: url)
        }
    }
    
}
