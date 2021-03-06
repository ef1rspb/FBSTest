final class FBSModuleFactory {}

extension FBSModuleFactory: AuthModuleFactory {

  func makeLoginOutput() -> LoginView {
    let viewController = LoginViewController()
    return viewController
  }

  func makeWebViewOutput(mode: WebViewMode) -> LoginView {
    let viewModel = WebViewViewModel(mode: mode)
    let viewController = WebViewViewController()
    viewController.viewModel = viewModel
    return viewController
  }
}

extension FBSModuleFactory: UserListModuleFactory {

  func makeUserDetailsOutput(userViewModel: UserViewModel) -> UserDetailsView {
    let viewModel = UserDetailsViewModel(userViewModel: userViewModel)
    let viewController = UserDetailsViewController()
    viewController.viewModel = viewModel
    return viewController
  }

  func makeUsersOutput() -> (UserListView, UserListProvider) {
    let authService = FBSAuthService()
    let networkService = NetworkServiceImpl(authService: authService)
    let provider = FBSUserService(networkService: networkService, imageLoader: networkService)
    let viewModel = UserListViewModelImpl(userListProvider: provider, userService: provider)
    let viewController = UserListViewController(style: .grouped)
    viewController.viewModel = viewModel
    return (viewController, provider)
  }
}
