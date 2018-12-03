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
    func getUsers() -> Observable<[User]>
    func updateUser(_ user: User)
}