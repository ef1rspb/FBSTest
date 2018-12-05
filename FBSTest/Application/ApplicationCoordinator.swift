final class ApplicationCoordinator: BaseCoordinator {

    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private let authService: AuthService

    init(router: Router, coordinatorFactory: CoordinatorFactory, authService: AuthService) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.authService = authService
    }

    override func start() {
        if !authService.isUserLoggedIn {
            runAuthFlow()
        } else {
            runUserListFlow()
        }
    }

    private func runAuthFlow() {
        let coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] token in
            self?.removeDependency(coordinator)
            self?.authService.saveSession(authToken: token)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    private func runUserListFlow() {
        let coordinator = coordinatorFactory.makeUserListCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.authService.logout()
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
