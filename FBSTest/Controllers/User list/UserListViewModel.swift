//
//  UserListViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class UserListViewModel {

    private let disposeBag = DisposeBag()

    private let userService: UserService
    private let userListProvider: UserListProvider

    init(userListProvider: UserListProvider, userService: UserService) {
        self.userListProvider = userListProvider
        self.userService = userService
    }
}

extension UserListViewModel {

    func loadCellViewModels(reload: Bool) -> Observable<[UserListCellViewModel]> {
        return userListProvider
            .getUsers()
            .map { $0.map { UserViewModel(user: $0, imageObservable: self.userListProvider.loadAvatarImage($0)) } }
            .map { $0.map { UserListCellViewModel(userViewModel: $0) } }
    }

    var userObservable: Observable<User?> {
        return userService.obtainUser()
    }
}
