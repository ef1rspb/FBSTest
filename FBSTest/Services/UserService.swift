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
        let user = User(nickname: "Sasha", avatarUrl: nil)
        return .just(user)
    }
}
