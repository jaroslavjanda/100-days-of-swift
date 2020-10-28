//
//  ViewController.swift
//  Project4
//
//  Created by Jaroslav Janda on 28/10/2019.
//  Copyright © 2019 Jaroslav Janda. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = [String]()
    var website: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func getUIBarButtons() -> [UIBarButtonItem] {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        return [backButton, forwardButton, spacer ,progressButton, spacer, refresh]
    }
    
    func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        toolbarItems = getUIBarButtons()
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        guard let website = website else {
            return
        }
        
        let url = URL(string: "https://" + website)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        let optionMenu = UIAlertController(title: "Choose a site..", message: nil, preferredStyle: .actionSheet)
        
        optionMenu.addAction(UIAlertAction(title: "Apple", style: .default, handler: clickOnSelect))
        optionMenu.addAction(UIAlertAction(title: "Wikipedia", style: .default, handler: clickOnSelect))
        optionMenu.addAction(UIAlertAction(title: "Hacking with Swift", style: .default, handler: clickOnSelect))
        optionMenu.addAction(UIAlertAction(title: "Google", style: .default, handler: clickOnSelect))
        optionMenu.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(optionMenu, animated: true)
    }
    
    func clickOnSelect(action: UIAlertAction) {
        var urlPath: URL?
        
        switch action.title {
        case "Apple":
            urlPath = URL(string: "https://www.apple.com")!
            break
        case "Wikipedia":
            urlPath = URL(string: "https://www.wikipedia.org")!
            break
        case "Google":
            urlPath = URL(string: "https://www.google.com")!
            break
        case "Hacking with Swift":
            urlPath = URL(string: "https://www.hackingwithswift.com")!
            break
        default:
            break
        }
        
        guard let urlPathReady = urlPath else {
            return
        }
        webView.load(URLRequest(url: urlPathReady))
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
        
        let alert = UIAlertController(title: "Permission", message: "You are not allowed to run this page", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
