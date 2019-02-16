//
//  ElementsViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/16/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

struct ElementsTableContent {
    let title: String
    let image: UIImage
    
    init(_ title: String, _ image: UIImage) {
        self.title = title
        self.image = image
    }
}

class ElementsViewController: BasicViewController {
    
    let cellId = "elementCellId"
    let tableView = UITableView()
    
    let contents: [ElementsTableContent] = [
        ElementsTableContent(L("1"), #imageLiteral(resourceName: "flagIcon_pan_asia")),
        ElementsTableContent(L("2"), #imageLiteral(resourceName: "flagIcon_pan_asia")),
        ElementsTableContent(L("3"), #imageLiteral(resourceName: "flagIcon_pan_asia")),
        ElementsTableContent(L("4"), #imageLiteral(resourceName: "flagIcon_pan_asia")),
    ]
    
    // MARK: - View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    private func setupTableView() {
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
        if indexPath.row < contents.count {
            cell.content = contents[indexPath.row]
        }
        return cell
    }
}

extension ElementsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
