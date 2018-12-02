//
//  UserListCellViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation

final class UserListCellViewModel {

    let title: String
    let user: User
    init(user: User) {
        title = user.nickname
        self.user = user
    }
}
