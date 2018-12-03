//
//  UserListProvider.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation
import RxSwift

protocol UserListProvider: class {
    func getUsers(reload: Bool) -> Observable<[User]>
    func loadAvatarImage(_ user: User) -> Observable<Data>
    func updateUser(_ user: UserViewModel)
}
