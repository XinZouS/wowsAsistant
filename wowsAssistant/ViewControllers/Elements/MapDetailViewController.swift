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
    fileprivate var plusImageView = UIImageView()
    fileprivate var controlTextLabel = UILabel()
    fileprivate var controlTextLableLending: NSLayoutConstraint?
    fileprivate var shareImageView = UIImageView()
    fileprivate var hertIconView = UIImageView()
    
    var backButton: UIButton?
    
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
        _ = createNavigationBarBackItem(button: backButton)
        
        // animations
        showBackButtonDuration(duration: 0.3)
        showControlViewDuration(duration: 0.3)
        
        setupBlurView()
    }
    
    private func setupControlViews() {
        let vs = view.safeAreaLayoutGuide
        view.addSubview(controlsViewContainer)
        controlsViewContainer.addConstraint(vs.leftAnchor, nil, vs.rightAnchor, nil, left: 0, top: 0, right: 0, bottom: 0, width: 0, height: 66)
        controlBottomConstrant = controlsViewContainer.bottomAnchor.constraint(equalTo: vs.bottomAnchor)
        controlBottomConstrant?.isActive = true
        
        // ???
        controlsViewContainer.addSubview(controlView)
        controlView.fillSuperviewByConstraint()
        
        let iconSize: CGFloat = 30
        controlView.addSubview(plusImageView)
        plusImageView.addConstraint(controlView.leftAnchor, nil, nil, nil, left: 20, top: 0, right: 0, bottom: 0, width: iconSize, height: iconSize)
        plusImageView.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        
        controlView.addSubview(controlTextLabel)
        controlTextLabel.translatesAutoresizingMaskIntoConstraints = false
        controlTextLabel.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        controlTextLableLending = controlTextLabel.leadingAnchor.constraint(equalTo: plusImageView.trailingAnchor)
        controlTextLableLending?.isActive = true
        
        controlView.addSubview(hertIconView)
        hertIconView.addConstraint(nil, nil, controlView.rightAnchor, nil, left: 0, top: 0, right: 20, bottom: 0, width: iconSize, height: iconSize)
        hertIconView.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
        
        controlView.addSubview(shareImageView)
        shareImageView.addConstraint(nil, nil, hertIconView.leftAnchor, nil, left: 0, top: 0, right: 20, bottom: 0, width: iconSize, height: iconSize)
        shareImageView.centerYAnchor.constraint(equalTo: controlView.centerYAnchor).isActive = true
    }
    
}

// MARK: helpers

extension MapDetailViewController {
    
    fileprivate func createBackButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 44))
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonHandler), for: .touchUpInside)
        return button
    }
    
    fileprivate func createNavigationBarBackItem(button: UIButton?) -> UIBarButtonItem? {
        guard let button = button else {
            return nil
        }
        
        let buttonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = buttonItem
        return buttonItem
    }
    
    fileprivate func setupBlurView() {
        let height = controlView.bounds.height + bottomSafeArea
        let blurViewFrame = CGRect(x: 0, y: view.frame.size.height - height, width: view.frame.width, height: height)
        let blurView = UIVisualEffectView(frame: blurViewFrame)
        blurView.effect = UIBlurEffect(style: .dark)
        controlsViewContainer.insertSubview(blurView, at: 0)
        blurView.fillSuperviewByConstraint()
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
        showControlButtonsDuration(duration: duration)
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
    
    fileprivate func showControlButtonsDuration(duration: Double) {
        [plusImageView, shareImageView, hertIconView].forEach {
            $0.rotateDuration(duration: duration, from: CGFloat.pi / 4, to: 0, delay: duration)
            $0.scaleDuration(duration: duration, from: 0.5, to: 1, delay: duration)
            $0.alpha = 0
            $0.opacityDuration(duration: duration, from: 0, to: 1, delay: duration, remove: false)
        }
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
