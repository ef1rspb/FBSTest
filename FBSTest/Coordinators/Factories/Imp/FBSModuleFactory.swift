final class FBSModuleFactory {}

extension FBSModuleFactory: AuthModuleFactory {

    func makeLoginOutput() -> LoginView {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel)
    }
}

extension FBSModuleFactory: UserListModuleFactory {

    func makeUsersOutput() -> UserListView {
        let provider = FBSUserService()
        let viewModel = UserListViewModel(userListProvider: provider)
        let viewController = UserListViewController(viewModel: viewModel)
        return viewController
    }

}
