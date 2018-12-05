protocol AuthModuleFactory {
    func makeLoginOutput() -> LoginView
    func makeWebViewOutput(mode: WebViewMode) -> LoginView
}
