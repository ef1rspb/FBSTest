//
//  WebViewViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/5/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation

final class WebViewViewModel {

    let mode: WebViewMode

    init(mode: WebViewMode) {
        self.mode = mode
    }
}

extension WebViewViewModel {

    var request: URLRequest? {
        switch mode {
        case .githubAuth:
            guard var urlComponents = URLComponents(string: mode.url) else {
                return nil
            }
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: "20c1ac54fee6308261d2")
            ]
            guard let url = urlComponents.url else {
                return nil
            }
            return URLRequest(url: url)
        }
    }

    func nextRequest(path url: String) -> URLRequest? {
        switch mode {
        case .githubAuth:
            guard let code = url.components(separatedBy: "code=").last else {
                return nil
            }
            let urlString = "https://github.com/login/oauth/access_token"
            guard var urlComponents = URLComponents(string: urlString) else {
                return nil
            }
            urlComponents.queryItems = [
                URLQueryItem(name: "code", value: code),
                URLQueryItem(name: "client_secret", value: "2c433b5552c9c51e666d8da801b8b172da6f75f6"),
                URLQueryItem(name: "client_id", value: "20c1ac54fee6308261d2")
            ]
            guard let url = urlComponents.url else {
                return nil
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
    }
}
