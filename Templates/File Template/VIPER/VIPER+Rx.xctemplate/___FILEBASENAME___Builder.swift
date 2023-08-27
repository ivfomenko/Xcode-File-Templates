import Foundation
import UIKit
import Swinject

struct ___VARIABLE_sceneName___Builder {
    static func build(injector: Container) -> ___VARIABLE_sceneName___ViewController {
        let viewController = ___VARIABLE_sceneName___ViewController.board(.___VARIABLE_sceneName___)

        let router = ___VARIABLE_sceneName___Router(injector: injector)
        router.viewController = viewController
        
        let interactor = ___VARIABLE_sceneName___InteractorImpl()
        
        let presenter = ___VARIABLE_sceneName___Presenter(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
