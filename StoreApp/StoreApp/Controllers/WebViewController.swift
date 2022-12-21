//
//  WebViewController.swift
//  StoreApp
//
//  Created by Marat on 20.12.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private let link: URL?
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .gray
        activity.style = .medium
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    private let toolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    private var goBackButton: UIBarButtonItem!
    private var goForwardButton: UIBarButtonItem!
    private var shareButton: UIBarButtonItem!
    private var refreshButton: UIBarButtonItem!
    
    private var webView: WKWebView!
    
    init(link: URL?) {
        self.link = link
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createWebView()
        createToolBar()
        
        view.addSubviews(activityIndicatorView, toolBar, webView)
        
        if let link = link {
            let urlRequest = URLRequest(url: link)
            webView.load(urlRequest)
        }
        
        setupConstraints()
    }
    
    // создание вебвью
    private func createWebView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        //self.view = webView
    }
    
    // тулбар для вебвью
    private func createToolBar() {
        toolBar.sizeToFit()
        goBackButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBackAction(_:)))
        let fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        goForwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"), style: .plain, target: self, action: #selector(goForwardAction(_:)))
        shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: nil, action: nil)
        refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(refreshAction(_:)))
        
        toolBar.items = [goBackButton, fixedSpaceButton, goForwardButton, fixedSpaceButton, shareButton, fixedSpaceButton, refreshButton]
    }
    
    // констрейнты
    private func setupConstraints() {
        setupActivityIndicatorViewConstraint()
        setupToolBarConstraint()
        setupWebViewConstraint()
    }
    
    private func setupActivityIndicatorViewConstraint() {
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupToolBarConstraint() {
        toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupWebViewConstraint() {
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: toolBar.topAnchor).isActive = true
    }
    
    @objc private func goBackAction(_ button: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc private func goForwardAction(_ button: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc private func refreshAction(_ button: UIBarButtonItem) {
        webView.reload()
    }
    
    private func shouldActivityIndicatorShow(_ flag: Bool) {
        if flag {
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
        } else {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
        }
    }
}


extension WebViewController: WKNavigationDelegate {
    // при начале загрузки
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        shouldActivityIndicatorShow(true)
        goBackButton.isEnabled = false
        goForwardButton.isEnabled = false
    }
    
    // при окончании загрузки
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        shouldActivityIndicatorShow(false)
        if webView.canGoBack {
            goBackButton.isEnabled = true
        }
        if webView.canGoForward {
            goForwardButton.isEnabled = true
        }
    }
}
