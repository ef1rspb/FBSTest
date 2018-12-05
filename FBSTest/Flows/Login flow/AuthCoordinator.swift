final class AuthCoordinator: BaseCoordinator, AuthCoordinatorOutput {

    var finishFlow: ((String) -> Void)?

    private let factory: AuthModuleFactory
    private let router: Router

    init(router: Router, factory: AuthModuleFactory) {
        self.factory = factory
        self.router = router
    }

    override func start() {
        showLogin()
    }

    private func showLogin() {
        let loginOutput = factory.makeLoginOutput()

        loginOutput.onLoginAction = { [weak self] method in
            self?.showLoginView(method: method)
        }

        router.setRootModule(loginOutput, hideBar: true, animated: true)
    }

    private func showLoginView(method: LoginMethod) {
        switch method {
        case .github:
            let output = factory.makeWebViewOutput(mode: .githubAuth)

            output.onCompleteAuth = { [weak self] token in
                self?.finishFlow?(token)
            }
            router.push(output, animated: true)
        }
    }
}
