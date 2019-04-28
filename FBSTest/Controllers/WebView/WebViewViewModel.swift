//
//  WebViewViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/5/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import RxSwift

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

  func authenticateWithTemporaryCode(_ code: String) -> Observable<String?> {
    let tokenUrl = URL(string: "https://github.com/login/oauth/access_token")!
    var req = URLRequest(url: tokenUrl)
    req.httpMethod = "POST"
    req.addValue("application/json", forHTTPHeaderField: "Content-Type")
    req.addValue("application/json", forHTTPHeaderField: "Accept")
    let params = [
      "client_id": "20c1ac54fee6308261d2",
      "client_secret": "2c433b5552c9c51e666d8da801b8b172da6f75f6",
      "code": code
    ]
    req.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])

    return URLSession.shared.rx
      .json(request: req)
      .map { $0 as? [String: Any] }
      .map { content -> String? in
        return content?["access_token"] as? String
      }
  }
}
