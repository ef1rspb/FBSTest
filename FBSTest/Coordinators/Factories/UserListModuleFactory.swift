protocol UserListModuleFactory {
    func makeUsersOutput() -> UserListView
    func makeUserDetailsOutput(user: User) -> UserDetailsView
}
