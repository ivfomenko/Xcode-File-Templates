import Foundation
import UIKit
import Swinject

struct ___VARIABLE_sceneName___Builder {
    
    static func build(injector: Container) -> ___VARIABLE_sceneName___ViewController {

        let viewController = ___VARIABLE_sceneName___ViewController.initFromStoryboard(name: AppStoryboards.___VARIABLE_sceneName___)
        
        let viewModel = ___VARIABLE_sceneName___ViewModel()
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
