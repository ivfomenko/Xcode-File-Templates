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

struct ___VARIABLE_sceneName___Builder {
    static func build(injector: Container) -> ___VARIABLE_sceneName___ViewController {
        let viewController = ___VARIABLE_sceneName___ViewController.initFromStoryboard(name: AppStoryboards.___VARIABLE_sceneName___)

        let router = ___VARIABLE_sceneName___Router(injector: injector)
        router.viewController = viewController
        
        let viewModel: ___VARIABLE_sceneName___ViewModelType = ___VARIABLE_sceneName___ViewModel(router: router)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
