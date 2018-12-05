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

        let (usersOutput, dataProvider) = factory.makeUsersOutput()
        usersOutput.onUserSelect = { [weak self, weak dataProvider] user in
            self?.showUserDetail(user, dataProvider: dataProvider)
        }
        usersOutput.onLogout = { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(usersOutput, hideBar: false, animated: true)
    }

    private func showUserDetail(_ user: UserViewModel, dataProvider: UserListProvider?) {

        let userDetailFlowOutput = factory.makeUserDetailsOutput(userViewModel: user)
        userDetailFlowOutput.onUserUpdated = { [weak self, weak dataProvider] user in
            dataProvider?.updateUser(user)
            self?.router.popModule(animated: true)
        }
        router.push(userDetailFlowOutput)
    }
}
