//
//  ApiTarget.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 26/04/2019.
//  Copyright © 2019 Aleksandr Malina. All rights reserved.
//

enum HTTPMethod {

  case get
  case post
  case delete
  case patch
  case put
}

protocol ApiTarget {

  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: [String: Any]? { get }
  var headers: [String: String]? { get }
}
