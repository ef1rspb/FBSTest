//
//  UITableView+Reuse.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 26/04/2019.
//  Copyright © 2019 Aleksandr Malina. All rights reserved.
//
import UIKit

extension UITableView {

  func registerClassForCell(_ cellClass: UITableViewCell.Type) {
    register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
  }

  func dequeueReusableCellWithType<T: UITableViewCell>(_ cellClass: T.Type) -> T? {
    return dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T
  }
}

extension NSObject {

  static var reuseIdentifier: String {
    return NSStringFromClass(self)
  }
}

