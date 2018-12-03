//
//  UserDetailsViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation

final class UserDetailsViewModel {
    private let user: User

    init(user: User) {
        self.user = user
    }

    func updatedUser(avatarImageData: Data?) -> User {
        return user.with(avatarImageData: avatarImageData)
    }
}

extension UserDetailsViewModel {

    var header: String {
        return user.nickname
    }

    var avatarImageData: Data? {
        return user.avatarImageData
    }
}
