import RxSwift
import RxCocoa

// MARK: - ___VARIABLE_sceneName___PresenterType
/// Abstract logic layer for ___VARIABLE_sceneName___PresenterType
public protocol ___VARIABLE_sceneName___PresenterType {}

// MARK: - ___VARIABLE_sceneName___Presenter
final public class ___VARIABLE_sceneName___Presenter {

    // - Private Properties
    private let disposeBag = DisposeBag()
    
    private let router: ___VARIABLE_sceneName___Navigation
    private let interactor: ___VARIABLE_sceneName___InteractorType

    // - Base
    init(router: ___VARIABLE_sceneName___Navigation, interactor: ___VARIABLE_sceneName___InteractorType) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - ___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___PresenterType
extension ___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___PresenterType {
    
}

