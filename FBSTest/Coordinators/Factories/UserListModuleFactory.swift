protocol UserListModuleFactory {
  func makeUsersOutput() -> (UserListView, UserListProvider)
  func makeUserDetailsOutput(userViewModel: UserViewModel) -> UserDetailsView
}
