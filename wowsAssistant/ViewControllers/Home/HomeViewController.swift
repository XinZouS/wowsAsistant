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
    let wowsNewsUrl = "https://worldofwarships.com/en/news/"
    
    let webView = WKWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        loadWebpageFromUrl()
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.addConstraint(view.leftAnchor, view.topAnchor, view.rightAnchor, view.bottomAnchor)
    }
    
    private func loadWebpageFromUrl() {
        guard let url = URL(string: wowsNewsUrl) else { return }
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: url))
            // TODO: use my activity indicator:
//            self.activityIndicator?.isHidden = false
//            self.activityIndicator?.animate()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        activityIndicator?.isHidden = true
//        activityIndicator?.stop()
    }
    
}
