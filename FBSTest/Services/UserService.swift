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

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func obtainUser() -> Observable<User> {
        let user = User(nickname: "Sasha", avatarUrl: nil, avatarImageData: nil)
        return .just(user)
    }
}

extension FBSUserService: UserListProvider {

    func getUsers() -> Observable<[User]> {
        return networkService.getUsers()
    }

    func updateUser(_ user: User) {
        print(user.avatarImageData!.count)
    }
}
