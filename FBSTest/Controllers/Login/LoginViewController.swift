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
    var onLoginAction: ((LoginMethod) -> Void)?
    var onCompleteAuth: ((String) -> Void)?

    private let disposeBag = DisposeBag()
    var viewModel: LoginViewModel!

    private(set) lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Login", for: .normal)
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.onLoginAction?(.github)
            })
            .disposed(by: disposeBag)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    private func addViews() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
