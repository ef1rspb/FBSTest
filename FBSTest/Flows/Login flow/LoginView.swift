protocol LoginView: BaseView {
  var onLoginAction: ((LoginMethod) -> Void)? { get set }
  var onCompleteAuth: ((String) -> Void)? { get set }
}
