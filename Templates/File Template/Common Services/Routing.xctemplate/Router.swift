//
//
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import Swinject

// MARK: - Closable
protocol Closable: class {
    func close(_ completion: (() -> Void)?)
    func pop(_ completion: (() -> Void)?)
    func pop(_ to: AppStoryboards, completion: (() -> Void)?)
    func root(_ completion: (() -> Void)?)
}

extension Closable {
    
    func close(completion: (() -> Void)? = nil) {
        self.close(completion)
    }
    
    func pop(completion: (() -> Void)? = nil) {
        self.pop(completion)
    }
    
    func pop(to: AppStoryboards, completion: (() -> Void)? = nil) {
        self.pop(to, completion: completion)
    }
    
    func root(completion: (() -> Void)? = nil) {
        self.root(completion)
    }
}

// MARK: - RouterProtocol
protocol RouterProtocol: class {
    
    associatedtype U: UIViewController
    
    var viewController: U? { get }
    
    var injector: Container { get set }
    
    func open(_ viewController: UIViewController, transition: Transition)
}

// MARK: - Router<U>
class Router<U>: RouterProtocol, InjectorProtocol, Closable where U: UIViewController {
    
    var injector: Container
    
    init(injector: Container) {
        self.injector = injector
    }
    
    typealias U = U
    
    #warning("Is this should be an optional value?")
    weak var viewController: U?
    
    var openTransition: Transition?

    func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }

    func close(_ completion: (() -> Void)?) {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.close(viewController, completion: completion)
    }
    
    func pop(_ completion: (() -> Void)? = nil) {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.pop(viewController, completion: completion)
    }
    
    func pop(_ to: AppStoryboards, completion: (() -> Void)? = nil) {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.pop(to: to, vc: viewController, completion: completion)
    }
    
    func root(_ completion: (() -> Void)? = nil) {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.root(viewController, completion: completion)
    }
}
