//
//  WebViewVC.swift
//  PecodeTask
//
//  Created by Эдип on 21.01.2022.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {
    
    let webView = WKWebView(frame: .zero)
    let spinner = UIActivityIndicatorView()
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapDone))
        configureWebView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    
    private func configureWebView() {
        view.addSubview(webView)
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        webView.load(URLRequest(url: url))
    }

    
    @objc func didTapDone() {
        dismiss(animated: true, completion: nil)
    }
}
