//
//  UIView++.swift
//  carryonex
//
//  Created by Xin Zou on 8/8/17.
//  Copyright © 2017 CarryonEx. All rights reserved.
//

import UIKit


extension UIView{
    
    /** Use leading,trailing anchor for some reverse left-right reading countries, in which the leading will be Right, trailing will be Left;
     *  ⚠️ if you don't know what you are doing, DON'T USE IT!
    */
    func anchor(_ leading: NSLayoutXAxisAnchor? = nil, _ top: NSLayoutYAxisAnchor? = nil, _ trailing: NSLayoutXAxisAnchor? = nil, _ bottom: NSLayoutYAxisAnchor? = nil, lead leadConstent: CGFloat = 0, top topConstent: CGFloat = 0, trail trailConstent: CGFloat = 0, bottom bottomConstent: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
        
        var anchors = [NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if leading != nil {
            anchors.append(leadingAnchor.constraint(equalTo: leading!, constant: leadConstent))
        }
        if top != nil {
            anchors.append(topAnchor.constraint(equalTo: top!, constant: topConstent))
        }
        if trailing != nil {
            anchors.append(trailingAnchor.constraint(equalTo: trailing!, constant: -trailConstent))
        }
        if bottom != nil {
            anchors.append(bottomAnchor.constraint(equalTo: bottom!, constant: -bottomConstent))
        }
        if width > CGFloat(0) {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height > CGFloat(0) {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        for anchor in anchors {
            anchor.isActive = true
        }
    }
    
    /// fixed Left-Right sided constraint, will not reverse all over the world; if TEXT reading related, use anchor()
    func addConstraint(_ left: NSLayoutXAxisAnchor? = nil, _ top: NSLayoutYAxisAnchor? = nil, _ right: NSLayoutXAxisAnchor? = nil, _ bottom: NSLayoutYAxisAnchor? = nil, left leftConstent: CGFloat = 0, top topConstent: CGFloat = 0, right rightConstent: CGFloat = 0, bottom bottomConstent: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {
        
        var anchors = [NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if left != nil {
            anchors.append(leftAnchor.constraint(equalTo: left!, constant: leftConstent))
        }
        if top != nil {
            anchors.append(topAnchor.constraint(equalTo: top!, constant: topConstent))
        }
        if right != nil {
            anchors.append(rightAnchor.constraint(equalTo: right!, constant: -rightConstent))
        }
        if bottom != nil {
            anchors.append(bottomAnchor.constraint(equalTo: bottom!, constant: -bottomConstent))
        }
        if width > CGFloat(0) {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height > CGFloat(0) {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        for anchor in anchors {
            anchor.isActive = true
        }
    }
    
    func anchorCenterIn(_ containerView: UIView?, width: CGFloat, height: CGFloat, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        guard let cv = containerView else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: cv.centerXAnchor, constant: offsetX).isActive = true
        centerYAnchor.constraint(equalTo: cv.centerYAnchor, constant: offsetY).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Use leftAnchor, rightAnchor constraints
    func fillSuperviewByConstraint(padding: UIEdgeInsets = .zero) {
        guard let sv = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        leftAnchor.constraint(equalTo: sv.leftAnchor, constant: padding.left).isActive = true
        topAnchor.constraint(equalTo: sv.topAnchor, constant: padding.top).isActive = true
        rightAnchor.constraint(equalTo: sv.rightAnchor, constant: -padding.right).isActive = true
        bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: -padding.bottom).isActive = true
    }
    
    /** Use leading,trailing anchor for some reverse left-right reading countries, in which the leading will be Right, trailing will be Left;
     *  ⚠️ if you don't know what you are doing, DON'T USE IT!
     */
    func fillSuperviewByLeadingTrailing(padding: UIEdgeInsets = .zero) {
        guard let sv = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        leadingAnchor.constraint(equalTo: sv.leadingAnchor, constant: padding.left).isActive = true
        topAnchor.constraint(equalTo: sv.topAnchor, constant: padding.top).isActive = true
        trailingAnchor.constraint(equalTo: sv.trailingAnchor, constant: -padding.right).isActive = true
        bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: -padding.bottom).isActive = true
    }
    
    func drawStroke(startPoint: CGPoint, endPoint: CGPoint, color: UIColor, lineWidth: CGFloat) {
        let aPath = UIBezierPath()
        aPath.move(to: startPoint)
        aPath.addLine(to: endPoint)
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = aPath.cgPath
        lineLayer.strokeColor = color.cgColor
        lineLayer.lineWidth = lineWidth
        lineLayer.lineJoin = CAShapeLayerLineJoin.round

        layer.addSublayer(lineLayer)
    }
}

extension UIView {
    
    func rotate360Degrees(duration: CFTimeInterval = 3) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat.pi * 2
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}


