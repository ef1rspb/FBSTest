//
//  WebViewViewController.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/5/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import RxSwift
import WebKit

final class WebViewViewController: UIViewController {

    var viewModel: WebViewViewModel!

    private var webView: WKWebView!

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let request = viewModel.request {
            webView.load(request)
        }
    }

}

extension WebViewViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let redirectUrlString = webView.url?.absoluteString else {
            return
        }
        if let request = viewModel.nextRequest(path: redirectUrlString) {
            webView.load(request)
        }
    }
}
