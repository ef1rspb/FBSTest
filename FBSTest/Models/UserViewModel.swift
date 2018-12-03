//
//  UserViewModel.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/3/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation
import UIKit.UIImage
import RxSwift
import RxCocoa

final class UserViewModel {
    let user: User

    private let imageSubject = BehaviorRelay<Data?>(value: nil)
    private let disposeBag = DisposeBag()

    init(user: User, imageObservable: Observable<Data>) {
        self.user = user
        imageObservable
            .bind(to: imageSubject)
            .disposed(by: disposeBag)
    }

    func updateImage(data: Data) {
        imageSubject.accept(data)
    }
}

extension UserViewModel {

    var imageDriver: Driver<UIImage> {
        return imageSubject
            .asObservable()
            .map { UIImage(data: $0 ?? Data()) ?? UIImage.User.avatarPlaceholder }
            .asDriver(onErrorJustReturn: UIImage.User.avatarPlaceholder)
    }

    var nickname: String {
        return user.nickname
    }

    var imageData: Data? {
        return imageSubject.value
    }
}
