//
//  KeychainService.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/5/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation
import KeychainAccess

final class KeychainService {

    static let shared = KeychainService()

    private init() { }

    private enum Constants {
        static let keychainService = "ru.malina.fbstest"
        static let authTokenKey = "authToken"
    }

    fileprivate lazy var keychain: Keychain = {
        Keychain(service: Constants.keychainService)
    }()

    var authToken: String? {
        get {
            return keychain[Constants.authTokenKey]
        }
        set {
            keychain[Constants.authTokenKey] = newValue
        }
    }

    func clear() {
        try? keychain.removeAll()
    }
}
