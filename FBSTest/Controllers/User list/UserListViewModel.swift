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

    init(userListProvider: UserListProvider) {
        userListProvider
            .getUsers()
            .map {
                $0.map { UserListCellViewModel(user: $0) } }
            .bind(to: userListRelay)
            .disposed(by: disposeBag)
    }
}

extension UserListViewModel {

    var userListObservable: Observable<[UserListCellViewModel]> {
        return userListRelay.asObservable()
    }
}
