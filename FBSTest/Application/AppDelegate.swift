//
//  AppDelegate.swift
//  FBSTest
//
//  Created by Aleksandr Malina on 12/1/18.
//  Copyright © 2018 Aleksandr Malina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  private var rootController: UINavigationController {
    return (self.window!.rootViewController as? UINavigationController)!
  }

  private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window!.rootViewController = UINavigationController()
    window!.makeKeyAndVisible()
    applicationCoordinator.start()
    return true
  }

  private func makeCoordinator() -> Coordinator {
    return ApplicationCoordinator(
      router: FBSRouter(rootController: self.rootController),
      coordinatorFactory: FBSCoordinatorFactory(),
      authService: FBSAuthService()
    )
  }
}
