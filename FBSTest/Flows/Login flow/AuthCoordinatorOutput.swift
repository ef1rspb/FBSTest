protocol AuthCoordinatorOutput: class {
    var finishFlow: ((String) -> Void)? { get set }
}
