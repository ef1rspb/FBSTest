//
//  UserDetailsViewController.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/2/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import RxSwift

final class UserDetailsViewController: UIViewController, UserDetailsView {

    var onUserUpdated: ((UserViewModel) -> Void)?
    var viewModel: UserDetailsViewModel!

    private let disposeBag = DisposeBag()

    private lazy var userAvatarImageView: UIImageView = {
        let image = UIImage.User.avatarPlaceholder
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

        updateImageButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showPhotoSourceAlert()
            })
            .disposed(by: disposeBag)

        viewModel.userViewModel
            .imageDriver
            .drive(onNext: { [weak self] in
                self?.userAvatarImageView.image = $0
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = .white
        title = viewModel.header
    }
}

extension UserDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage]! as? UIImage {
            userAvatarImageView.image = image
            viewModel.updateUser(avatarImageData: image.pngData())
            onUserUpdated?(viewModel.userViewModel)
        }
    }
}

extension UserDetailsViewController {

    func showPhotoSourceAlert() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            self?.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { [weak self] _ in
            self?.openGallery()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning",
                                           message: "You don't have perission to access camera",
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    private func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning",
                                           message: "You don't have perission to access gallery.",
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
