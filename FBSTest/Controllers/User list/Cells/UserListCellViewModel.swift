//
//  UserListCellViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation
import RxSwift

final class UserListCellViewModel {

    let title: String
    let user: User
    let imageObservable: Observable<Data>?

    init(user: User, imageObservable: Observable<Data>?) {
        title = user.nickname
        self.user = user
        self.imageObservable = imageObservable
    }
}
