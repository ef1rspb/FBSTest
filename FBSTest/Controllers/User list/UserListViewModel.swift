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

final class UserListViewModel {

    private let userListSubject = BehaviorSubject<[UserListCellViewModel]>(value: [])
    private let disposeBag = DisposeBag()

    init(userListProvider: UserListProvider) {
        userListProvider
            .getUsers()
            .map { $0.map { UserListCellViewModel(user: $0) } }
            .bind(to: userListSubject)
            .disposed(by: disposeBag)
    }
}

extension UserListViewModel {

    var userListObservable: Observable<[UserListCellViewModel]> {
        return userListSubject.asObservable()
    }
}
