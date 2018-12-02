//
//  UserDetailsViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation
import RxSwift

final class UserDetailsViewModel {
    private let user: User
    private let userProvider: UserListProvider

    init(user: User, userProvider: UserListProvider) {
        self.user = user
        self.userProvider = userProvider
    }
}

extension UserDetailsViewModel {

    func updateUserAvatar(data: Data) -> Observable<Bool> {
        let updatedUser = User(nickname: user.nickname,
                               avatarUrl: user.avatarUrl,
                               avatarImageData: data)
        return userProvider.updateUser(updatedUser)
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
