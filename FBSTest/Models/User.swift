//
//  User.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/1/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation

/// GitHub user model
struct User: Codable {

  let nickname: String
  let avatarUrl: String

  enum CodingKeys: String, CodingKey {
    case nickname = "login"
    case avatarUrl = "avatar_url"
  }
}
