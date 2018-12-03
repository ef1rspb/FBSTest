protocol UserDetailsView: BaseView {
    var onUserUpdated: ((User) -> Void)? { get set }
}
