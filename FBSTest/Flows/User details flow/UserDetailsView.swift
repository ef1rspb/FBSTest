protocol UserDetailsView: BaseView {
  var onUserUpdated: ((UserViewModel) -> Void)? { get set }
}
