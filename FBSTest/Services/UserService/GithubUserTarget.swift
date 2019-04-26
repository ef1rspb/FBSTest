//
//  GithubUserTarget.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 26/04/2019.
//  Copyright © 2019 Aleksandr Malina. All rights reserved.
//

enum GithubUserTarget: ApiTarget {

  case userList
  case currentUserProfile

  var path: String {
    switch self {
    case .userList:
      return "/users"
    case .currentUserProfile:
      return "/user"
    }
  }

  var method: HTTPMethod {
    return .get
  }

  var parameters: [String: Any]? {
    return nil
  }

  var headers: [String: String]? {
    return nil
  }
}
