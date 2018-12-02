import Foundation

protocol UserDetailsView: BaseView {
    var onImageUpdated: ((Data) -> Void)? { get set }
}
