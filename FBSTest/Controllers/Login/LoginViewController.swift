//
//  LoginViewController.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/1/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit
import LeadKit

class LoginViewController: BaseConfigurableController<LoginViewModel>, LoginView {
    var onCompleteAuth: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
