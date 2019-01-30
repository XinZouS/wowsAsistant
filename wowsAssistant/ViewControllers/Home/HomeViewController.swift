//
//  HomeViewController.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/23/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import UIKit
import WebKit

class HomeViewController: BasicViewController, WKNavigationDelegate {
    
    // https://worldofwarships.asia/zh-tw/news/
    // https://worldofwarships.com/en/news/
    // http://wows.kongzhong.com/wows.html
    let wowsNewsUrl = "https://worldofwarships.com/en/news/"
    
    let webView = WKWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        loadWebpageFromUrl(wowsNewsUrl)
        setupButtons()
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.addConstraint(view.leftAnchor, view.topAnchor, view.rightAnchor, view.bottomAnchor)
    }
    
    private func loadWebpageFromUrl(_ urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: url))
            // TODO: use my activity indicator:
//            self.activityIndicator?.isHidden = false
//            self.activityIndicator?.animate()
        }
    }
    
    private func setupButtons() {
        let h: CGFloat = 40
        let w: CGFloat = view.bounds.width / 3
        let btnSz = CGRect(x: 0, y: 0, width: w, height: h)
        
        let homeBtn = UIButton()
        let forwBtn = UIButton()
        let backBtn = UIButton()
        homeBtn.addTarget(self, action: #selector(homeBtnTapped), for: .touchUpInside)
        forwBtn.addTarget(self, action: #selector(forwBtnTapped), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        let tClr = UIColor.WowsTheme.buttonGreenTop
        let bClr = UIColor.WowsTheme.buttonGreenBot
        homeBtn.setupGradient(tClr, bClr, bounds: btnSz, title: L("home.button.home.title"), textColor: .white)
        forwBtn.setupGradient(tClr, bClr, bounds: btnSz, title: L("home.button.forw.title"), textColor: .white)
        backBtn.setupGradient(tClr, bClr, bounds: btnSz, title: L("home.button.back.title"), textColor: .white)
        
        let stackView = UIStackView(arrangedSubviews: [homeBtn, backBtn, forwBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        let sv = self.view.safeAreaLayoutGuide
        stackView.addConstraint(sv.leftAnchor, nil, sv.rightAnchor, sv.bottomAnchor, left: 0, top: 0, right: 0, bottom: 0, width: 0, height: h)
    }
    
    @objc private func  homeBtnTapped() {
        loadWebpageFromUrl(wowsNewsUrl)
    }
    
    @objc private func  forwBtnTapped() {
        webView.goForward()
    }
    
    @objc private func  backBtnTapped() {
        webView.goBack()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        activityIndicator?.isHidden = true
//        activityIndicator?.stop()
    }
    
}
