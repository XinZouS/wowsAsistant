//
//  ViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/12/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
    }
    
    private func setupChildViewControllers() {
        let homeVC = UIViewController()
        let findVC = FindShipViewController()
        let infoVC = UIViewController()
        let meVC = UIViewController()
        setup(viewController: homeVC, title: L("tabbar.icon.home.title"), icon: #imageLiteral(resourceName: "anchor_hollow_blk"))
        setup(viewController: findVC, title: L("tabbar.icon.find.title"), icon: #imageLiteral(resourceName: "telescope"))
        setup(viewController: infoVC, title: L("tabbar.icon.academy.title"), icon: #imageLiteral(resourceName: "book"))
        setup(viewController: meVC, title: L("tabbar.icon.account.title"), icon: #imageLiteral(resourceName: "captain_hat"))
        viewControllers = [homeVC, findVC, infoVC, meVC]
    }
    
    private func setup(viewController vc: UIViewController, title: String, icon: UIImage) {
        vc.title = title
        vc.tabBarItem.title = title
        vc.tabBarItem.image = icon
    }
    
}

