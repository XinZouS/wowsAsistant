//
//  MapDetailViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/26/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

class MapDetailViewController: PTDetailViewController {
    
    fileprivate var controlBottomConstrant: NSLayoutConstraint?
    
    // bottom control icons
    fileprivate var controlsViewContainer = UIView()
    fileprivate var controlView = UIView()
    fileprivate var controlTextLabel = UILabel()
    fileprivate var controlTextLableLending: NSLayoutConstraint?
    
    var backButton: UIButton?
    var mapDescription: String? {
        didSet {
            if let str = mapDescription {
                controlTextLabel.text = str
            }
        }
    }
    
    var bottomSafeArea: CGFloat {
        var result: CGFloat = 0
        if #available(iOS 11.0, *) {
            result = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        return result
    }
    
}


// MARK: life cicle

extension MapDetailViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControlViews()
        
        backButton = createBackButton()
        createNavigationBarBackItem(button: backButton)
        
        // animations
        showBackButtonDuration(duration: 0.3)
        showControlViewDuration(duration: 0.3)
    }
    
    private func setupControlViews() {
        let vs = view.safeAreaLayoutGuide
        view.addSubview(controlsViewContainer)
        controlsViewContainer.addConstraint(vs.leftAnchor, nil, vs.rightAnchor, nil, left: 0, top: 0, right: 0, bottom: 0, width: 0, height: 100)
        controlBottomConstrant = controlsViewContainer.bottomAnchor.constraint(equalTo: vs.bottomAnchor)
        controlBottomConstrant?.isActive = true
        
        // ???
        controlsViewContainer.addSubview(controlView)
        controlView.fillSuperviewByConstraint()
        controlView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        let labelMargin: CGFloat = 30
        controlView.addSubview(controlTextLabel)
        controlTextLabel.translatesAutoresizingMaskIntoConstraints = false
        controlTextLabel.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        controlTextLableLending = controlTextLabel.leadingAnchor.constraint(equalTo: controlView.leadingAnchor, constant: labelMargin)
        controlTextLableLending?.isActive = true
        controlTextLabel.trailingAnchor.constraint(equalTo: controlView.trailingAnchor, constant: -labelMargin).isActive = true
        controlTextLabel.textColor = .white
        controlTextLabel.numberOfLines = 4
    }
    
}

// MARK: helpers

extension MapDetailViewController {
    
    fileprivate func createBackButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 44))
        button.setImage(#imageLiteral(resourceName: "universal_back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonHandler), for: .touchUpInside)
        return button
    }
    
    fileprivate func createNavigationBarBackItem(button: UIButton?) {
        guard let button = button else {
            return
        }
        let buttonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = buttonItem
    }
    
}

// MARK: animations

extension MapDetailViewController {
    
    fileprivate func showBackButtonDuration(duration: Double) {
        backButton?.rotateDuration(duration: duration, from: -CGFloat.pi / 4, to: 0)
        backButton?.scaleDuration(duration: duration, from: 0.5, to: 1)
        backButton?.opacityDuration(duration: duration, from: 0, to: 1)
    }
    
    fileprivate func showControlViewDuration(duration: Double) {
        moveUpControllerDuration(duration: duration)
        showControlLabelDuration(duration: duration)
    }
    
    fileprivate func moveUpControllerDuration(duration: Double) {
        
        controlBottomConstrant?.constant = -controlsViewContainer.bounds.height
        view.layoutIfNeeded()
        
        controlBottomConstrant?.constant = 0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func showControlLabelDuration(duration: Double) {
        controlTextLabel.alpha = 0
        controlTextLabel.opacityDuration(duration: duration, from: 0, to: 1, delay: duration, remove: false)
        
        // move rigth
        let offSet: CGFloat = 20
        controlTextLableLending?.constant -= offSet
        view.layoutIfNeeded()
        
        controlTextLableLending?.constant += offSet
        UIView.animate(withDuration: duration * 2, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: actions

extension MapDetailViewController {
    
    @objc func backButtonHandler() {
        popViewController()
    }
}
