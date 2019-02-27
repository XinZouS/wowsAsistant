//
//  MapsTableViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class MapsTableViewController: PTTableViewController {
    
    var maps: [Map] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        self.tableView.register(MapsTableCell.self, forCellReuseIdentifier: MapsTableCell.cellIdentifier)
        fetchMapsData()
    }
    
    fileprivate func configureNavigationBar() {
        //transparent background
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
        ]
    }
    
    private func fetchMapsData() {
        print("fetchMapsData()")
        ApiServers.shared.getMaps { [weak self] (getMaps) in
            print("fetchMapsData(): check self...")
            guard let `self` = self else { return }
            self.maps.append(contentsOf: getMaps)
            print("success get maps = \(getMaps.count)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension MapsTableViewController {
    
    public override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return maps.count
    }
    
    public override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MapsTableCell else { return }
        
        if indexPath.row < maps.count {
            cell.mapModel = maps[indexPath.row]
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MapsTableCell.cellIdentifier, for: indexPath) as? MapsTableCell {
            if indexPath.row < maps.count {
                cell.mapModel = maps[indexPath.row]
            }
            return cell
        }
        return UITableViewCell(frame: .zero)
    }
    
    public override func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        let vc = MapDetailViewController()
        pushViewController(vc)
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}


