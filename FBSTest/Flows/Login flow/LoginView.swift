protocol LoginView: BaseView {
    var onCompleteAuth: (() -> Void)? { get set }
}
