protocol CoordinatorFactory {
  func makeAuthCoordinator(router: Router) -> Coordinator & AuthCoordinatorOutput
  func makeUserListCoordinator(router: Router) -> Coordinator & UserListCoordinatorOutput
}
