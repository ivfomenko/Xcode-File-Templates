import Foundation

protocol ___VARIABLE_sceneName___Route {
    var ___VARIABLE_sceneName___Transition: Transition { get }
    
    func show___VARIABLE_sceneName___()
}

extension ___VARIABLE_sceneName___Route where Self: RouterProtocol {
    
    func show___VARIABLE_sceneName___() {
        let viewController = ___VARIABLE_sceneName___Builder.build(injector: injector)
        open(viewController, transition: ___VARIABLE_sceneName___Transition)
    }
}
