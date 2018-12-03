final class FBSModuleFactory {}

extension FBSModuleFactory: AuthModuleFactory {

    func makeLoginOutput() -> LoginView {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel)
    }
}

extension FBSModuleFactory: UserListModuleFactory {

    func makeUserDetailsOutput(userViewModel: UserViewModel) -> UserDetailsView {
        let viewModel = UserDetailsViewModel(userViewModel: userViewModel)
        let viewController = UserDetailsViewController(viewModel: viewModel)
        return viewController
    }

    func makeUsersOutput() -> (UserListView, UserListProvider) {
        let networkService = DefaultNetorkService()
        let provider = FBSUserService(networkService: networkService)
        let viewModel = UserListViewModel(userListProvider: provider, userService: provider)
        let viewController = UserListViewController(viewModel: viewModel)
        return (viewController, provider)
    }

}
