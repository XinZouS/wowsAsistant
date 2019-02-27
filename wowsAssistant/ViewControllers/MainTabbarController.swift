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
        ShipInfoBasicManager.shared.loadShipInfoBasicIfNeed()
        tabBar.tintColor = UIColor.WowsTheme.buttonRedBot
    }
    
    private func setupChildViewControllers() {
        let homeVC = HomeViewController()
        let findVC = FindShipViewController()
        let elemVC = ElementsViewController()
        let meVC = UIViewController()
        setup(viewController: homeVC, title: L("tabbar.icon.home.title"), icon: #imageLiteral(resourceName: "anchor_hollow_blk"))
        setup(viewController: findVC, title: L("tabbar.icon.find.title"), icon: #imageLiteral(resourceName: "telescope"))
        setup(viewController: elemVC, title: L("tabbar.icon.academy.title"), icon: #imageLiteral(resourceName: "book"))
//        setup(viewController: meVC, title: L("tabbar.icon.account.title"), icon: #imageLiteral(resourceName: "captain_hat"))
        viewControllers = [homeVC, findVC, elemVC] //, meVC]
    }
    
    private func setup(viewController vc: UIViewController, title: String, icon: UIImage) {
        vc.title = title
        vc.tabBarItem.title = title
        vc.tabBarItem.image = icon
    }
    
}

extension MainTabbarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let items = tabBar.items else { return }
        //
    }
}
