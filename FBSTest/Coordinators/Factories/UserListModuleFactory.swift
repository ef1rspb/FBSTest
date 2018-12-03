protocol UserListModuleFactory {
    func makeUsersOutput() -> (UserListView, UserListProvider)
    func makeUserDetailsOutput(user: User) -> UserDetailsView
}
