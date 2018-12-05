final class FBSCoordinatorFactory: CoordinatorFactory {

    func makeAuthCoordinator(router: Router) -> Coordinator & AuthCoordinatorOutput {
        let coordinator = AuthCoordinator(router: router, factory: FBSModuleFactory())
        return coordinator
    }

    func makeUserListCoordinator(router: Router)
        -> Coordinator & UserListCoordinatorOutput {
        let coordinator = UserListCoordinator(
            router: router,
            factory: FBSModuleFactory(),
            coordinatorFactory: FBSCoordinatorFactory()
        )
        return coordinator
    }
}
