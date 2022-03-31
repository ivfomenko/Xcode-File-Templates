//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import RxSwift
import RxCocoa

// MARK: - ___VARIABLE_sceneName___Interactor
/// Abstract logic layer for ___VARIABLE_sceneName___PresenterImpl
protocol ___VARIABLE_sceneName___Presenter {
    
}

// MARK: - ___VARIABLE_sceneName___PresenterImpl
final class ___VARIABLE_sceneName___PresenterImpl {

    // - Private Properties
    private let disposeBag = DisposeBag()
    
    private let router: ___VARIABLE_sceneName___Navigation
    private let interactor: ___VARIABLE_sceneName___Interactor

    // - Base
    init(router: ___VARIABLE_sceneName___Navigation, interactor: ___VARIABLE_sceneName___Interactor) {
        self.router = router
        self.interactor = interactor
    }

}

// MARK: - ___VARIABLE_sceneName___PresenterImpl: ___VARIABLE_sceneName___Presenter
extension ___VARIABLE_sceneName___PresenterImpl : ___VARIABLE_sceneName___Presenter {
    
}

