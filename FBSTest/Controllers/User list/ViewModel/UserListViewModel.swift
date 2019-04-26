//
//  UserListViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import RxSwift

protocol UserListViewModel: class {

  var githubUsers: Observable<[User]> { get }
  var user: Observable<User?> { get }
}

final class UserListViewModelImpl: UserListViewModel {

  var githubUsers: Observable<[User]> {
    return userListProvider.getUsers()
  }

  var user: Observable<User?> {
    return userService.obtainUser()
  }

  private let userService: UserService
  private let userListProvider: UserListProvider

  init(userListProvider: UserListProvider, userService: UserService) {
    self.userListProvider = userListProvider
    self.userService = userService
  }
}
