final class FBSModuleFactory {}

extension FBSModuleFactory: AuthModuleFactory {

    func makeLoginOutput() -> LoginView {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel)
    }
}
