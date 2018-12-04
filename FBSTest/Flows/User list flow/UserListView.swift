protocol UserListView: BaseView {
    var onUserSelect: ((UserViewModel) -> Void)? { get set }
    var onLogout: (() -> Void)? { get set }
}
