//
//  UserDetailsViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

final class UserDetailsViewModel {

  let userViewModel: UserViewModel

  init(userViewModel: UserViewModel) {
    self.userViewModel = userViewModel
  }

  func updateUserAvatar(_ image: Image) {
    userViewModel.updateAvatar(image)
  }
}

extension UserDetailsViewModel {

  var header: String {
    return userViewModel.user.nickname
  }
}
