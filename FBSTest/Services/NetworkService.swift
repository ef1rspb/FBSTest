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
    func getUsers() -> Observable<[User]>
    func loadImage(url: String) -> Observable<Data>
}

final class DefaultNetorkService: NetworkService {

    private enum Constants {
        static let githubUsersUrl = "https://api.github.com/users"
    }

    func getUsers() -> Observable<[User]> {
        let url = URL(string: Constants.githubUsersUrl)!
        let request = URLRequest(url: url)
        return URLSession.shared.rx
            .data(request: request)
            .map { data in
                return (try? JSONDecoder().decode([User].self, from: data)) ?? []
            }
    }

    func loadImage(url: String) -> Observable<Data> {
        return Observable.create { observer in
            let url = URL(string: url)!
            let request = URLRequest(url: url)

            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let data = data {
                    observer.onNext(data)
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
}
