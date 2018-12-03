//
//  UserService.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/1/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import RxSwift

protocol UserService: class {
    func obtainUser() -> Observable<User>
}

final class FBSUserService: UserService {

    func obtainUser() -> Observable<User> {
        let user = User(nickname: "Sasha", avatarUrl: nil, avatarImageData: nil)
        return .just(user)
    }
}

extension FBSUserService: UserListProvider {

    func getUsers() -> Observable<[User]> {
        let user1 = User(nickname: "user1", avatarUrl: nil, avatarImageData: nil)
        let user2 = User(nickname: "user2", avatarUrl: nil, avatarImageData: nil)
        return .just([user1, user2])
    }

    func updateUser(_ user: User) {
        print(user.avatarImageData!.count)
    }
}
