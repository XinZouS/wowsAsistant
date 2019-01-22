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
        view.backgroundColor = .yellow
        
//        let url = "https://api.worldofwarships.ru/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&language=zh-cn&limit=6&ship_id=3763255248"
//        ApiServers.shared.getDDs(url: url) { (getDictionary) in
//            print(getDictionary)
//        }
        
        ApiServers.shared.getShipById(3762173776) { (shipInfo) in
            if let info = shipInfo {
                print("----- get ship description = \(info.description ?? "xxx")")
            }
        }
    }
    
    

}

