//
//  UIAlertController++.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/30/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    /// Initialize an alert view titled "Oops" with `message` and single "OK" action with no handler
    convenience init(message: String?) {
        self.init(title: "Oops", message: message, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: L("action.ok"), style: .default)
        addAction(dismissAction)
        
        preferredAction = dismissAction
    }
    
    /// Initialize an alert view titled "Oops" with `message` and "Retry" / "Skip" actions
    convenience init(message: String?, retryHandler: @escaping (UIAlertAction) -> Void) {
        self.init(title: "Oops", message: message, preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: L("action.redo"), style: .default, handler: retryHandler)
        addAction(retryAction)
        
        let skipAction = UIAlertAction(title: "Skip", style: .default)
        addAction(skipAction)
        
        preferredAction = skipAction
    }
}

// MARK: - In UIViewController, not AlertController, yet extension mainly for Alert;
extension UIViewController {
    
    func displayOkAlert(title: String, message: String, action: String, completion: (() -> Void)? = nil) {
        let v = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: action, style: .default) { (action) in
            completion?()
        }
        v.addAction(action)
        
        present(v, animated: true, completion: nil)
    }
    
    func displayAlertOkCancel(title: String, message: String, completion:((UIAlertAction.Style) -> Void)?) {
        let v = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L("action.ok"), style: .default) { (action) in
            completion?(action.style)
        }
        let cancelAction = UIAlertAction(title: L("action.cancel"), style: .cancel) { (action) in
            completion?(action.style)
        }
        v.addAction(okAction)
        v.addAction(cancelAction)
        
        present(v, animated: true, completion: nil)
    }
    
    /**
     * Alert with multiple actions, completion:(tag) -> Void;
     * In general, you should setup iPadReferenceView just in case;
     */
    func displayAlertActions(style:UIAlertController.Style = .actionSheet, title:String, message:String? = nil, actions:[String], iPadReferenceView refView:UIView, completion:((Int) -> Void)?) {
        let v = UIAlertController(title: title, message: message, preferredStyle: style)
        v.popoverPresentationController?.sourceView = refView
        
        for i in 0..<actions.count {
            let action = UIAlertAction(title: actions[i], style: .default) { (action) in
                completion?(i)
            }
            v.addAction(action)
        }
        if style == .actionSheet {
            let cancelBtn = UIAlertAction(title: L("action.cancel"), style: .cancel, handler: { [weak self] (action) in
                self?.dismiss(animated: true, completion: nil)
            })
            v.addAction(cancelBtn)
        }
        
        present(v, animated: true, completion: nil)
    }
    
}
