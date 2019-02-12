//
//  ShipDetailHeaderView.swift
//  wowsAssistant
//
//  Created by Xin Zou on 2/10/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit

protocol ShipDetailHeaderDelegate: class {
    func expandSection(_ isExpand: Bool, section: Int)
}

class ShipDetailHeaderView: UIView {
    
    var pair: Pair? {
        didSet {
            updateUI()
        }
    }
    var section = 0
    var isExpanded = false
    weak var delegate: ShipDetailHeaderDelegate?
    
    private let viewH: CGFloat = 30
    private let nameLabel = UILabel()
    private let valueLabel = UILabel()
    private let valueBar = UIView()
    private let valueBarHightCollected: CGFloat = 5
    private var valueBarHightConstraint: NSLayoutConstraint?
    private var valueBarWidthConstraint: NSLayoutConstraint?
    private let expandButtonImageView = UIImageView()
    private let expandButton = UIButton()
    private var isAllowAnimate = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    
    private func setupUI() {
        backgroundColor = UIColor.WowsTheme.gradientBlueDark
        let font = UIFont.boldSystemFont(ofSize: 14)
        
        valueBar.backgroundColor = UIColor.WowsTheme.buttonGreenBot
        addSubview(valueBar)
        valueBar.addConstraint(leftAnchor, nil, nil, bottomAnchor, left: 0, top: 0, right: 0, bottom: 0)
        valueBarHightConstraint = valueBar.heightAnchor.constraint(equalToConstant: viewH)
        valueBarHightConstraint?.isActive = true
        valueBarWidthConstraint = valueBar.widthAnchor.constraint(equalToConstant: 0)
        valueBarWidthConstraint?.isActive = true
        
        let valueBarEndLine = UIView()
        valueBarEndLine.backgroundColor = UIColor.WowsTheme.lineCyan
        addSubview(valueBarEndLine)
        valueBarEndLine.addConstraint(valueBar.rightAnchor, valueBar.topAnchor, nil, valueBar.bottomAnchor, left: 0, top: 0, right: 0, bottom: 0, width: 2, height: 0)
        
        expandButtonImageView.image = #imageLiteral(resourceName: "arrow_white_right")
        expandButtonImageView.contentMode = .scaleAspectFit
        addSubview(expandButtonImageView)
        let margin: CGFloat = 10
        expandButtonImageView.addConstraint(leftAnchor, nil, nil, nil, left: margin, top: 0, right: 0, bottom: 0, width: margin, height: margin)
        expandButtonImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rotateUpdateExpandButton()
        
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = font
        addSubview(nameLabel)
        nameLabel.addConstraint(expandButtonImageView.rightAnchor, nil, nil, nil, left: margin, top: 0, right: 0, bottom: 0)
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        valueLabel.textColor = .white
        valueLabel.textAlignment = .right
        valueLabel.font = font
        addSubview(valueLabel)
        valueLabel.addConstraint(nameLabel.rightAnchor, nil, rightAnchor, nil, left: margin, top: 0, right: margin, bottom: 0)
        valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        expandButton.addTarget(self, action: #selector(arrowButtonTapped), for: .touchUpInside)
        addSubview(expandButton)
        expandButton.addConstraint(leftAnchor, topAnchor, rightAnchor, bottomAnchor, left: 0, top: 0, right: 0, bottom: 0, width: 0, height: 0)
    }
    
    private func updateUI() {
        guard let p = pair else { return }
        nameLabel.text = p.title
        let valTxt = "\(p.value)"
        valueLabel.text = valTxt
        if let v = p.value as? Int {
            valueBarWidthConstraint?.constant = UIScreen.main.bounds.width * CGFloat(v) / 100
        }
        valueBarHightConstraint?.constant = isExpanded ? viewH : valueBarHightCollected
        rotateUpdateExpandButton()
    }
    
    @objc private func arrowButtonTapped() {
        if !isAllowAnimate { return }
        
        isAllowAnimate = false
        isExpanded = !isExpanded
        delegate?.expandSection(isExpanded, section: section)
        
        valueBarHightConstraint?.constant = isExpanded ? viewH : valueBarHightCollected
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let degree: CGFloat = (self?.isExpanded ?? false) ? 90 : 0
            let rotation = CGAffineTransform(rotationAngle: CGFloat.pi * degree / 180)
            self?.expandButtonImageView.transform = rotation
            self?.layoutIfNeeded()
            
        }) { [weak self] (finished) in
            self?.isAllowAnimate = finished
        }
    }
    
    private func rotateUpdateExpandButton() {
        let degree: CGFloat = isExpanded ? 90 : 0
        let rotation = CGAffineTransform(rotationAngle: CGFloat.pi * degree / 180)
        expandButtonImageView.transform = rotation
        DispatchQueue.main.async { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
}

