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
    let userViewModel: UserViewModel

    init(userViewModel: UserViewModel) {
        title = userViewModel.user.nickname
        self.userViewModel = userViewModel
    }
}
