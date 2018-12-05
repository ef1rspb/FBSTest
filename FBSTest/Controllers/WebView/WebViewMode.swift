//
//  WebViewMode.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/5/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

enum WebViewMode {
    case githubAuth
}

extension WebViewMode {

    var title: String {
        switch self {
        case .githubAuth:
            return "GitHub Authentication"
        }
    }

    var url: String {
        switch self {
        case .githubAuth:
            return "https://github.com/login/oauth/authorize"
        }
    }
}
