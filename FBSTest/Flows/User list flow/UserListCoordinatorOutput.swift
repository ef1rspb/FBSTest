//
//  UserListCoordinatorOutput.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import Foundation

protocol UserListCoordinatorOutput: class {
    var finishFlow: (() -> Void)? { get set }
}
