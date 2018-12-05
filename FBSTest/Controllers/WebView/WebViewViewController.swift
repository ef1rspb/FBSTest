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

final class WebViewViewController: UIViewController, LoginView {

    var onLoginAction: ((LoginMethod) -> Void)?
    var onCompleteAuth: ((String) -> Void)?

    var viewModel: WebViewViewModel!

    private var webView: WKWebView!
    private let disposeBag = DisposeBag()

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
        navigationController?.isNavigationBarHidden = false
    }

}

extension WebViewViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let givenUrl = webView.url?.absoluteString else {
            return
        }
        
        if givenUrl.contains("code="), let code = givenUrl.components(separatedBy: "code=").last {
            viewModel
                .authenticateWithTemporaryCode(code)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] token in
                    if let token = token {
                        self?.onCompleteAuth?(token)
                    }
                })
                .disposed(by: disposeBag)
        }
    }
}
