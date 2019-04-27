//
//  UserListCell.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class UserListCell: UITableViewCell {

  typealias CellData = UserViewModel

  private var disposeBag = DisposeBag()

  private enum Constants {
    static let avatarSize: CGFloat = 40
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  private let avatarImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage.User.avatarPlaceholder)
    imageView.layer.cornerRadius = Constants.avatarSize / 2
    imageView.clipsToBounds = true
    return imageView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupLayout()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    disposeBag = DisposeBag()
  }

  private func setupLayout() {
    setupAvatarImage()
    setupTitleLabel()
  }

  private func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
      titleLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
    ])
  }

  private func setupAvatarImage() {
    contentView.addSubview(avatarImageView)
    avatarImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: layoutMargins.left),
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: layoutMargins.top),
      avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -layoutMargins.bottom),
      avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarSize),
      avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSize)
    ])
  }

  func configure(with data: CellData) {
    titleLabel.text = data.nickname
    data
      .imageDriver
      .drive(onNext: { [weak self] in
        self?.avatarImageView.image = $0
      })
      .disposed(by: disposeBag)
  }
}
