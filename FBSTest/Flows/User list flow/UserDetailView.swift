protocol UserDetailView: BaseView {
    var onUpdateImageSelect: (() -> Void)? { get set }
}
