//
//  UIImageView+Extensions.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 26/04/2019.
//  Copyright © 2019 Aleksandr Malina. All rights reserved.
//

import UIKit

extension UIImageView {

  func load(from url: String, placeholder: UIImage = UIImage.User.avatarPlaceholder) {
    guard let url = URL(string: url) else {
      image = placeholder
      return
    }

    DispatchQueue.global().async {
      let data = try? Data(contentsOf: url)

      DispatchQueue.main.async {
        if let data = data {
          self.image = UIImage(data: data)
        } else {
          self.image = placeholder
        }
      }
    }
  }
}
