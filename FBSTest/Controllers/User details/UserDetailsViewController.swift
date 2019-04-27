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

  // MARK: - Callbacks

  var onUserUpdated: ((UserViewModel) -> Void)?

  // MARK: - Properties

  var viewModel: UserDetailsViewModel!

  private let disposeBag = DisposeBag()

  private lazy var avatarImageView: UIImageView = {
    let image = UIImage.User.avatarPlaceholder
    let imageView = UIImageView(image: image)
    imageView.backgroundColor = .gray
    return imageView
  }()

  private lazy var updateImageButton: UIButton = {
    let button = UIButton()
    button.setTitle("Update image", for: .normal)
    button.setTitleColor(.blue, for: .normal)

    return button
  }()

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()

    viewModel.userViewModel
      .imageDriver
      .drive(onNext: { [unowned self] in
        self.avatarImageView.image = $0
      })
      .disposed(by: disposeBag)
  }

  // MARK: - Setup view

  private func setupView() {
    view.backgroundColor = .white
    title = viewModel.header

    setupAvatar()
    setupUpdateImageButton()
  }

  private func setupAvatar() {
    view.addSubview(avatarImageView)
    avatarImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
    ])
  }

  private func setupUpdateImageButton() {
    view.addSubview(updateImageButton)
    updateImageButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      updateImageButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
      updateImageButton.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
    ])

    updateImageButton.rx.tap
      .subscribe(onNext: { [unowned self] in
        self.showPhotoSourceAlert()
      })
      .disposed(by: disposeBag)
  }
}

extension UserDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    picker.dismiss(animated: true, completion: nil)
    if let image = info[UIImagePickerController.InfoKey.originalImage]! as? UIImage {
      avatarImageView.image = image
      viewModel.updateUser(avatarImageData: image.pngData())
      onUserUpdated?(viewModel.userViewModel)
    }
  }
}

// MARK: - Image picker

extension UserDetailsViewController {

  enum ImagePickerSourceType {

    case camera
    case photoLibrary

    var alertMessage: String {
      switch self {
      case .camera:
        return "You don't have perission to access camera"
      case .photoLibrary:
        return "You don't have perission to access gallery."
      }
    }

    var uiImagePickerControllerSourceType: UIImagePickerController.SourceType {
      switch self {
      case .camera:
        return .camera
      case .photoLibrary:
        return .photoLibrary
      }
    }
  }

  private func showImagePicker(type: ImagePickerSourceType) {
    let sourceType = type.uiImagePickerControllerSourceType
    if UIImagePickerController.isSourceTypeAvailable(sourceType) {
      let imagePicker = createImagePicker(sourceType: sourceType, delegate: self)
      present(imagePicker, animated: true, completion: nil)
    } else {
      let alert = createWarningOkAlert(message: type.alertMessage)
      present(alert, animated: true, completion: nil)
    }
  }

  private func showPhotoSourceAlert() {
    let alert = createChoosePhotoSourceView()
    present(alert, animated: true, completion: nil)
  }

  private func createChoosePhotoSourceView() -> UIViewController {
    let alert = UIAlertController(title: "Choose source", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
      self?.showImagePicker(type: .camera)
    })

    alert.addAction(UIAlertAction(title: "Gallery", style: .default) { [weak self] _ in
      self?.showImagePicker(type: .photoLibrary)
    })

    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    return alert
  }

  private func createWarningOkAlert(message: String) -> UIViewController {
    let alert  = UIAlertController(
      title: "Warning",
      message: message,
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alert
  }

  private func createImagePicker(
    sourceType: UIImagePickerController.SourceType,
    delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
    ) -> UIViewController {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = delegate
    imagePicker.sourceType = sourceType

    return imagePicker
  }
}
