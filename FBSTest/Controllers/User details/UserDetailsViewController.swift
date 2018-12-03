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

final class UserDetailsViewController: BaseConfigurableController<UserDetailsViewModel>,
                                        UserDetailsView,
                                        UIImagePickerControllerDelegate,
                                        UINavigationControllerDelegate {

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
                self?.showPhotoSourceAlert()
            })
            .disposed(by: disposeBag)
    }

    override func configureAppearance() {
        view.backgroundColor = .white
        title = viewModel.header
    }

    // we couldn't conformance to UIImagePickerControllerDelegate,
    // because of BaseConfigurableController generic class
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage]! as? UIImage {
            userAvatarImageView.image = image
            if let data = image.pngData() {
                onImageUpdated?(data)
            }
        }
    }
}

extension UserDetailsViewController {

    func showPhotoSourceAlert() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

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
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
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
