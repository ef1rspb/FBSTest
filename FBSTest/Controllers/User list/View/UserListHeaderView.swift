//
//  UserListHeaderView.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 26/04/2019.
//  Copyright © 2019 Aleksandr Malina. All rights reserved.
//

import UIKit

final class UserListHeaderView: UIView {

  private let avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 15
    imageView.layer.masksToBounds = true
    return imageView
  }()

  private let usernameLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  private enum Constants {

    static let avatarSize: CGFloat = 70
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupLayout()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupLayout() {
    translatesAutoresizingMaskIntoConstraints = false
    let stackView = UIStackView(arrangedSubviews: [avatarImageView, usernameLabel])
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.distribution = .fill
    stackView.alignment = .center
    addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSize),
      avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarSize),
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: layoutMargins.top),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: layoutMargins.left),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: layoutMargins.right),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -layoutMargins.bottom)
    ])
  }

  func configure(with user: User) {
    usernameLabel.text = user.nickname
    avatarImageView.load(from: user.avatarUrl)
  }
}
