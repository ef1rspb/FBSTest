protocol CoordinatorFactory {
    func makeAuthCoordinator(router: Router) -> Coordinator & AuthCoordinatorOutput
}
