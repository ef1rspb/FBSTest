final class FBSModuleFactory {}

extension FBSModuleFactory: AuthModuleFactory {

    func makeLoginOutput() -> LoginView {
        return LoginController()
    }
}

