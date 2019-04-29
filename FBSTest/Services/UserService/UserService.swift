//
//  UserService.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/1/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import RxSwift

protocol UserService: class {

  func obtainUser() -> Observable<User?>
}

final class FBSUserService: UserService {

  private let networkService: NetworkService
  private let imageLoader: ImageLoader
  private var userAvatarCacheByNickname: [String: Image] = [:]

  init(networkService: NetworkService, imageLoader: ImageLoader) {
    self.networkService = networkService
    self.imageLoader = imageLoader
  }

  func obtainUser() -> Observable<User?> {
    return networkService.makeRequest(to: GithubUserTarget.currentUserProfile)
  }
}

extension FBSUserService: UserListProvider {

  func loadUserAvatar(_ user: User) -> Observable<Image> {
    if let data = userAvatarCacheByNickname[user.nickname] {
      return .just(data)
    } else {
      return imageLoader.loadImage(user.avatarUrl)
    }
  }

  func getUsers() -> Observable<[User]> {
    return networkService.makeRequest(to: GithubUserTarget.userList)
  }

  func updateUser(_ user: UserViewModel) {
    userAvatarCacheByNickname[user.nickname] = user.avatar
  }
}
