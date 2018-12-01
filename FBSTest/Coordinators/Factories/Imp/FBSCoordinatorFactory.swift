final class FBSCoordinatorFactory: CoordinatorFactory {

    func makeAuthCoordinator(router: Router) -> Coordinator & AuthCoordinatorOutput {
        let coordinator = AuthCoordinator(router: router, factory: FBSModuleFactory())
        return coordinator
    }
}
