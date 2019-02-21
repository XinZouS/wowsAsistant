//
//  ItemBaseViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/20/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class ItemBaseViewController: BasicViewController {
    
    internal let tableView = UITableView(frame: .zero)
    
    // MARK: - View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    internal func setupTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        let vs = self.view.safeAreaLayoutGuide
        view.addSubview(tableView)
        tableView.addConstraint(vs.leftAnchor, vs.topAnchor, vs.rightAnchor, vs.bottomAnchor, left: 0, top: 0, right: 0, bottom: 0)
    }
    
}
