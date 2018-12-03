//
//  UserListViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation
import LeadKit
import RxSwift
import RxCocoa

final class UserListViewModel {

    private let userListRelay = BehaviorRelay<[UserListCellViewModel]>(value: [])
    private let disposeBag = DisposeBag()

    private let userService: UserService

    init(userListProvider: UserListProvider, userService: UserService) {
        userListProvider
            .getUsers()
            .map { [weak userListProvider] users in
                return users.map { UserListCellViewModel(user: $0,
                                                         imageObservable: userListProvider?.loadAvatarImage($0)) }
            }
            .bind(to: userListRelay)
            .disposed(by: disposeBag)

        self.userService = userService
    }
}

extension UserListViewModel {

    var userListObservable: Observable<[UserListCellViewModel]> {
        return userListRelay.asObservable()
    }

    var userObservable: Observable<User> {
        return userService.obtainUser()
    }
}
