final class FBSModuleFactory {}

extension FBSModuleFactory: AuthModuleFactory {

    func makeLoginOutput() -> LoginView {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel)
    }
}

extension FBSModuleFactory: UserListModuleFactory {

    func makeUserDetailsOutput(user: User) -> UserDetailsView {
        let provider = FBSUserService()
        let viewModel = UserDetailsViewModel(user: user, userProvider: provider)
        let viewController = UserDetailsViewController(viewModel: viewModel)
        return viewController
    }

    func makeUsersOutput() -> UserListView {
        let provider = FBSUserService()
        let viewModel = UserListViewModel(userListProvider: provider)
        let viewController = UserListViewController(viewModel: viewModel)
        return viewController
    }

}
