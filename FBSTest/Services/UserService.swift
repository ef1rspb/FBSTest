//
//  UserService.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/1/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import RxSwift

protocol UserService: class {
    func obtainUser() -> Observable<User?>
}

final class FBSUserService: UserService {

    private let networkService: NetworkService
    private var usersCache: [String: Data] = [:]

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func obtainUser() -> Observable<User?> {
        return networkService.obtainUser()
    }
}

extension FBSUserService: UserListProvider {

    func loadAvatarImage(_ user: User) -> Observable<Data> {
        if let data = usersCache[user.nickname] {
            return .just(data)
        } else {
            return networkService.loadImage(url: user.avatarUrl)
        }
    }

    func getUsers(reload: Bool = false) -> Observable<[User]> {
        return networkService
            .getUsers()
    }

    func updateUser(_ user: UserViewModel) {
        usersCache[user.nickname] = user.imageData
    }
}
