//
//  LoginViewController.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/1/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import RxSwift

final class LoginViewController: UIViewController, LoginView {

  // MARK: - Callbacks
  var onLoginAction: ((LoginMethod) -> Void)?
  var onCompleteAuth: ((String) -> Void)?

  // MARK: - Properties
  private let disposeBag = DisposeBag()

  private let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("Login", for: .normal)
    return button
  }()

  private enum ViewConstants {

    static let loginButtonWidth: CGFloat = 100
    static let loginButtonHeight: CGFloat = 50
  }

  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    addViews()
    bind()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.isNavigationBarHidden = true
  }

  // MARK: - Setup view
  private func addViews() {
    addLoginButton()
  }

  private func addLoginButton() {
    view.addSubview(loginButton)
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loginButton.widthAnchor.constraint(equalToConstant: ViewConstants.loginButtonWidth),
      loginButton.heightAnchor.constraint(equalToConstant: ViewConstants.loginButtonHeight),
      loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  private func bind() {
    loginButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.onLoginAction?(.github)
      })
      .disposed(by: disposeBag)
  }
}
