protocol UserListView: BaseView {
    var onUserSelect: ((User) -> Void)? { get set }
    var onLogout: (() -> Void)? { get set }
}
