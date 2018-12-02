final class UserListCoordinator: BaseCoordinator, UserListCoordinatorOutput {
    var finishFlow: (() -> Void)?

    private let factory: UserListModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    init(router: Router, factory: UserListModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }

    override func start() {
        showUserList()
    }

    private func showUserList() {

        let usersOutput = factory.makeUsersOutput()
        usersOutput.onUserSelect = { [weak self] (user) in
            self?.showUserDetail(user)
        }
        usersOutput.onLogout = { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(usersOutput)
    }

    private func showUserDetail(_ user: User) {

        let userDetailFlowOutput = factory.makeUserDetailsOutput(user: user)
        userDetailFlowOutput.onImageUpdated = { [weak self] _ in
            self?.router.popModule(animated: true)
        }
        router.push(userDetailFlowOutput)
    }
}
