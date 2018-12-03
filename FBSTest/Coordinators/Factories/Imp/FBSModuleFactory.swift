final class FBSModuleFactory {}

extension FBSModuleFactory: AuthModuleFactory {

    func makeLoginOutput() -> LoginView {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel)
    }
}

extension FBSModuleFactory: UserListModuleFactory {

    func makeUserDetailsOutput(user: User) -> UserDetailsView {
        let viewModel = UserDetailsViewModel(user: user)
        let viewController = UserDetailsViewController(viewModel: viewModel)
        return viewController
    }

    func makeUsersOutput() -> (UserListView, UserListProvider) {
        let provider = FBSUserService()
        let viewModel = UserListViewModel(userListProvider: provider, userService: provider)
        let viewController = UserListViewController(viewModel: viewModel)
        return (viewController, provider)
    }

}
