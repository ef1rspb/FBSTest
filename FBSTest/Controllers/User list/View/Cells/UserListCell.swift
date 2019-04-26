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

  typealias CellData = (title: String, userViewModel: UserViewModel)

    private var disposeBag = DisposeBag()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        return label
    }()

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        let width: CGFloat = 80.0
        imageView.layer.cornerRadius = width / 2
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: width).isActive = true
        return imageView
    }()

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }

  func configure(with data: CellData) {
    titleLabel.text = data.title
    data.userViewModel
      .imageDriver
      .drive(onNext: { [weak self] in
        self?.avatarImageView.image = $0
      })
      .disposed(by: disposeBag)
  }

}
