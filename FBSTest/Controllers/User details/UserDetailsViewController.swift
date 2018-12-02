//
//  UserDetailsViewController.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import RxSwift
import LeadKit

final class UserDetailsViewController: BaseConfigurableController<UserDetailsViewModel>, UserDetailsView {

    var onImageUpdated: ((Data) -> Void)?

    private let disposeBag = DisposeBag()

    private lazy var userAvatarImageView: UIImageView = {
        var image = UIImage.User.avatarPlaceholder
        if let data = viewModel.avatarImageData {
            image = UIImage(data: data) ?? image
        }
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        return imageView
    }()

    private lazy var updateImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update image", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: 20).isActive = true
        button.centerXAnchor.constraint(equalTo: userAvatarImageView.centerXAnchor).isActive = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

    override func bindViews() {
        updateImageButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onImageUpdated?(Data([1, 2, 3]))
            })
            .disposed(by: disposeBag)
    }

    override func configureAppearance() {
        view.backgroundColor = .white
        title = viewModel.header
    }
}
