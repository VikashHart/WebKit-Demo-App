//
//  WebViewController.swift
//  FellowsWeb
//
//  Created by C4Q on 1/25/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class WebViewController: UIViewController {
    
    private var urlRequest: URLRequest!
    
    // Ideally this should be its own view class
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let wv = WKWebView(frame: view.bounds, configuration: config)
        wv.navigationDelegate = self
        return wv
    }()
    
    init(urlRequest: URLRequest) {
        super.init(nibName:nil, bundle: nil)
        self.urlRequest = urlRequest
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.load(urlRequest)
        //TODO: start spinner
        SVProgressHUD.show()
    }


}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("did fail: \(error)")
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //TODO: stop spinner
        print("did finish: \(navigation.description)")
        SVProgressHUD.dismiss()
    }
}
