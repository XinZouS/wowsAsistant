//
//  ElementsViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/16/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

enum ElementKind {
    case commanderSkills
    case consumables
    case collections
    case maps
}

struct ElementsTableContent {
    let kind: ElementKind
    let title: String
    let image: UIImage
    
    init(_ kind: ElementKind, _ title: String, _ image: UIImage) {
        self.kind = kind
        self.title = title
        self.image = image
    }
}

class ElementsViewController: BasicViewController {
    
    let cellId = "elementCellId"
    let tableView = UITableView()
    
    let contents: [ElementsTableContent] = [
        ElementsTableContent(ElementKind.commanderSkills, L("Commander Skills"), #imageLiteral(resourceName: "commanders")),
        ElementsTableContent(ElementKind.consumables, L("Consumables"), #imageLiteral(resourceName: "consumablesTitleImg")),
        ElementsTableContent(ElementKind.collections, L("Collections"), #imageLiteral(resourceName: "collections")),
        ElementsTableContent(ElementKind.maps, L("Maps"), #imageLiteral(resourceName: "map_titleImg")),
    ]
    
    // MARK: - View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.register(ElementsTableCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.fillSuperviewByConstraint()
    }
    
}


extension ElementsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ElementsTableCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if indexPath.row < contents.count {
            cell.content = contents[indexPath.row]
        }
        return cell
    }
}

extension ElementsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 140 : 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= contents.count { return }
        
        let kind = contents[indexPath.row].kind
        switch kind {
        case .commanderSkills:
            let vc = CommanderSkillsViewController()
            vc.title = contents[indexPath.row].title
            AppDelegate.shared().mainNavigationController?.pushViewController(vc, animated: true)
            
        case .consumables:
            let vc = ConsumablesViewController()
            vc.title = contents[indexPath.row].title
            AppDelegate.shared().mainNavigationController?.pushViewController(vc, animated: true)
            
        case .collections:
            print(" open collections")
            
        case .maps:
            print(" open maps")
        }
    }
    
}
