//
//  UserDetailsViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation

final class UserDetailsViewModel {
    let userViewModel: UserViewModel

    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
    }

    func updateUser(avatarImageData: Data?) {
        guard let data = avatarImageData else {
            return
        }
        userViewModel.updateImage(data: data)
    }

}

extension UserDetailsViewModel {

    var header: String {
        return userViewModel.user.nickname
    }
}
