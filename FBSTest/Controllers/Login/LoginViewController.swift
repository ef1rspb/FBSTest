//
//  LoginViewController.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/1/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import LeadKit
import RxSwift

class LoginViewController: BaseConfigurableController<LoginViewModel>, LoginView {
    var onLoginAction: ((LoginMethod) -> Void)?
    var onCompleteAuth: ((String) -> Void)?

    private let disposeBag = DisposeBag()

    private(set) lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Login", for: .normal)
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.login()
            })
            .disposed(by: disposeBag)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoadView()
    }

    override func addViews() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension LoginViewController {

    private func login() {
        onLoginAction?(.github)
    }
}
