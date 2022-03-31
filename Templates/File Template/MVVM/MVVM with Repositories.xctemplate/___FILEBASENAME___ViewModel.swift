//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import RxSwift
import RxCocoa

// MARK: - ___VARIABLE_sceneName___ViewModel
protocol ___VARIABLE_sceneName___ViewModel {
    
}

// MARK: -  ___VARIABLE_sceneName___ViewModelImpl
final class ___VARIABLE_sceneName___ViewModelImpl {
    
    // - Private Properties
    private let router: ___VARIABLE_sceneName___Navigation
    private let useCases: UseCases
    
    private let disposeBag = DisposeBag()

    // - Base
    init(router: ___VARIABLE_sceneName___Navigation, useCases: UseCases) {
        self.router = router
        self.useCases = useCases
    }

}
