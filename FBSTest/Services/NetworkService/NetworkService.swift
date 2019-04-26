//
//  NetworkService.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/3/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import RxSwift
import RxCocoa

protocol NetworkService: class {

  func makeRequest<T: Decodable>(to target: ApiTarget) -> Observable<T>
}

final class NetworkServiceImpl: NetworkService {
  private let authService: AuthService?

  let baseUrl = "https://api.github.com"

  init(authService: AuthService? = nil) {
    self.authService = authService
  }

  func makeRequest<T: Decodable>(to target: ApiTarget) -> Observable<T> {
    let request = createRequest(for: target)

    return Observable.create { observer in
      let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
        if let data = data, let decodedData = try? JSONDecoder().decode(T.self, from: data) {
          observer.onNext(decodedData)
        } else if let error = error {
          observer.onError(error)
        }
        observer.onCompleted()
      }
      task.resume()

      return Disposables.create {
        task.cancel()
      }
    }
  }

  private func createRequest(for target: ApiTarget) -> URLRequest {
    let url = URL(string: baseUrl + target.path)!
    var request = URLRequest(url: url)
    if let token = authService?.authToken {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    return request
  }
}
