//
//  User+Extensions.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit

extension User {

    var avatarImage: UIImage {
        if let data = avatarImageData {
            return UIImage(data: data) ?? UIImage.User.avatarPlaceholder
        } else {
            return UIImage.User.avatarPlaceholder
        }
    }

    func with(avatarImageData data: Data?) -> User {
        return User(nickname: self.nickname,
                    avatarUrl: self.avatarUrl,
                    avatarImageData: data)
    }
}
