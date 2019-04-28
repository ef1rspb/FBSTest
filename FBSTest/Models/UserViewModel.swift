//
//  UserViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/3/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit.UIImage
import RxSwift
import RxCocoa

typealias Image = UIImage

final class UserViewModel {

  let user: User

  private let avatarSubject = BehaviorSubject<Image>(value: Image.User.avatarPlaceholder)
  private let disposeBag = DisposeBag()

  init(user: User, image: Observable<Image>) {
    self.user = user
    image
      .subscribe(onNext: { [weak self] in
        self?.avatarSubject.onNext($0)
      })
      .disposed(by: disposeBag)
  }

  func updateAvatar(_ image: Image) {
    avatarSubject.onNext(image)
  }
}

extension UserViewModel {

  var avatarObservable: Observable<Image> {
    return avatarSubject.asObservable()
  }

  var nickname: String {
    return user.nickname
  }

  var avatar: Image {
    return (try? avatarSubject.value()) ?? Image.User.avatarPlaceholder
  }
}
