//
//  UserListCell.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import TableKit
import LeadKit
import RxSwift
import RxCocoa

final class UserListCell: SeparatorCell {

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
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }

}

extension UserListCell: ConfigurableCell {

    static let defaultHeight: CGFloat? = 100

    func configure(with viewModel: UserListCellViewModel) {
        titleLabel.text = viewModel.title
        viewModel.userViewModel
            .imageDriver
            .drive(onNext: { [weak self] in
                self?.avatarImageView.image = $0
            })
            .disposed(by: disposeBag)
    }
}
