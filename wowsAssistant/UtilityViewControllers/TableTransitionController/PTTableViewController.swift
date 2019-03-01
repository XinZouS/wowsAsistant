//
//  TableViewController.swift
//  AppFunFeautres
//
//  Created by Xin Zou on 2/24/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

//
// MARK: - The base viewController of the table
//

fileprivate func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

/// Base UITableViewController for preview transition
open class PTTableViewController: UITableViewController {
    
    internal var currentCell: PTTableCell?
    
    fileprivate var duration: Double = 1.0 // original: 0.8
    fileprivate var currentTextLabel: MovingLabel?
}

// MARK: public
public extension PTTableViewController {
    
    /**
     Pushes a view controller onto the receiver’s stack and updates the display whith custom animation.
     - parameter viewController: The view controller to push onto the stack.
     */
    public func pushViewController(_ viewController: PTDetailViewController) {
        
        guard let currentCell = currentCell,
            let navigationController = self.navigationController else {
                #if DEBUG
                fatalError("current cell is empty or add navigationController")
                #else
                return
                #endif
        }
        
        if let currentIndex = tableView.indexPath(for: currentCell) {
            let nextIndex = IndexPath(row: (currentIndex as NSIndexPath).row + 1, section: (currentIndex as NSIndexPath).section)
            if case let nextCell as PTTableCell = tableView.cellForRow(at: nextIndex) {
                nextCell.showTopSeparator()
                nextCell.superview?.bringSubviewToFront(nextCell)
            }
        }
        
        currentTextLabel = createTitleLable(currentCell)
        currentTextLabel?.move(duration, direction: .up, completion: nil)
        
        currentCell.openCell(tableView, duration: duration)
        moveCells(tableView, currentCell: currentCell, duration: duration)
        if let bgImage = currentCell.bgImage?.image {
            viewController.bgImage = bgImage
        }
        if let text = currentCell.parallaxTitle?.text {
            viewController.titleText = text
        }
        if let mapCell = currentCell as? MapsTableCell,
            let mapDescription = mapCell.mapModel?.description,
            let mapVC = viewController as? MapDetailViewController {
            mapVC.mapDescription = mapDescription
        }
        delay(duration) {
            navigationController.pushViewController(viewController, animated: false)
        }
    }
}

// MARK: life cicle
extension PTTableViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            tableView.contentInset = UIEdgeInsets.init(top: -64, left: 0, bottom: 0, right: 0)
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        moveCellsBackIfNeed(duration) {
            self.tableView.reloadData()
        }
        closeCurrentCellIfNeed(duration)
        moveDownCurrentLabelIfNeed()
    }
}

// MARK: create
extension PTTableViewController {
    
    fileprivate func createTitleLable(_ cell: PTTableCell) -> MovingLabel {
        
        let yPosition = cell.frame.origin.y + cell.frame.size.height / 2.0 - 22 - tableView.contentOffset.y
        let label = MovingLabel(frame: CGRect(x: 0, y: yPosition, width: UIScreen.main.bounds.size.width, height: 44))
        label.textAlignment = .center
        label.backgroundColor = .clear
        if let font = cell.parallaxTitle?.font,
            let text = cell.parallaxTitle?.text,
            let textColor = cell.parallaxTitle?.textColor {
            label.font = font
            label.text = text
            label.textColor = textColor
        }
        
        navigationController?.view.addSubview(label)
        return label
    }
    
    fileprivate func createSeparator(_ color: UIColor?, height: CGFloat, cell: UITableViewCell) -> MovingView {
        
        let yPosition = cell.frame.origin.y + cell.frame.size.height - tableView.contentOffset.y
        let separator = MovingView(frame: CGRect(x: 0.0, y: yPosition, width: tableView.bounds.size.width, height: height))
        if let color = color {
            separator.backgroundColor = color
        }
        separator.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.view.addSubview(separator)
        return separator
    }
}

// MARK: tableView dataSource
extension PTTableViewController {
    
    public final override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? PTTableCell else {
            return indexPath
        }
        self.currentCell = currentCell
        return indexPath
    }
}

// MARK: helpers
extension PTTableViewController {
    
    fileprivate func parallaxOffsetDidChange(_: CGFloat) {
        
        _ = tableView.visibleCells
            .filter { $0 != currentCell }
            .forEach { if case let cell as PTTableCell = $0 { cell.parallaxOffset(tableView) } }
    }
    
    fileprivate func moveCellsBackIfNeed(_ duration: Double, completion: @escaping () -> Void) {
        guard let currentCell = self.currentCell,
            let currentIndex = tableView.indexPath(for: currentCell) else {
                return
        }
        
        for case let cell as PTTableCell in tableView.visibleCells where cell != currentCell {
            if cell.isMovedHidden == false { continue }
            
            if let index = tableView.indexPath(for: cell) {
                let direction = (index as NSIndexPath).row < (currentIndex as NSIndexPath).row ? PTTableCell.Direction.up : PTTableCell.Direction.down
                cell.animationMoveCell(direction, duration: duration, tableView: tableView, selectedIndexPaht: currentIndex, close: true)
                cell.isMovedHidden = false
            }
        }
        delay(duration, closure: completion)
    }
    
    fileprivate func closeCurrentCellIfNeed(_ duration: Double) {
        guard let currentCell = self.currentCell else { return }
        currentCell.closeCell(duration, tableView: tableView) { () -> Void in
            self.currentCell = nil
        }
    }
    
    fileprivate func moveDownCurrentLabelIfNeed() {
        guard let currentTextLabel = self.currentTextLabel else { return }
        currentTextLabel.move(duration, direction: .down) { _ in
            currentTextLabel.removeFromSuperview()
            self.currentTextLabel = nil
        }
    }
    
    //  animtaions
    fileprivate func moveCells(_ tableView: UITableView, currentCell: PTTableCell, duration: Double) {
        guard let currentIndex = tableView.indexPath(for: currentCell) else { return }
        
        for case let cell as PTTableCell in tableView.visibleCells where cell != currentCell {
            cell.isMovedHidden = true
            let row = (tableView.indexPath(for: cell) as NSIndexPath?)?.row
            let direction = row < (currentIndex as NSIndexPath).row ? PTTableCell.Direction.down : PTTableCell.Direction.up
            cell.animationMoveCell(direction, duration: duration, tableView: tableView, selectedIndexPaht: currentIndex, close: false)
        }
    }
}

// MARK: ScroolViewDelegate
extension PTTableViewController {
    
    open override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        parallaxOffsetDidChange(scrollView.contentOffset.y)
    }
}