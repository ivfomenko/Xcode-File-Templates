//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import UIKit
import Swinject

final class ___VARIABLE_sceneName___Builder {
    static func build(injector: Container) -> ___VARIABLE_sceneName___ViewController {
        let viewController = ___VARIABLE_sceneName___ViewController.initFromStoryboard(name: AppStoryboards.___VARIABLE_sceneName___)

        let router = ___VARIABLE_sceneName___Router(injector: injector)
        router.viewController = viewController
        
        let useCases: ___VARIABLE_sceneName___ViewModel.UseCases = ___VARIABLE_sceneName___Repository()
        
        let viewModel = ___VARIABLE_sceneName___ViewModel(router: router, useCases: useCases)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
