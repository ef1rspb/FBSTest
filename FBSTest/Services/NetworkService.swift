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
}
