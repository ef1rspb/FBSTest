//
//  AuthService.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/5/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation

protocol AuthService {
    var isUserLoggedIn: Bool { get }
    var authToken: String? { get }
    func logout()
    func saveSession(authToken: String)
}

final class FBSAuthService: AuthService {

    enum Constants {
        static let authHeaderName = "Authorization"
    }

    var isUserLoggedIn: Bool {
        return KeychainService.shared.authToken != nil
    }

    var authToken: String? {
        return KeychainService.shared.authToken
    }

    var authHeaders: [String: String]? {
        guard let authToken = KeychainService.shared.authToken else {
            return nil
        }

        return [Constants.authHeaderName: authToken]
    }

    func logout() {
        KeychainService.shared.clear()
    }

    func saveSession(authToken: String) {
        KeychainService.shared.authToken = authToken
    }
}
