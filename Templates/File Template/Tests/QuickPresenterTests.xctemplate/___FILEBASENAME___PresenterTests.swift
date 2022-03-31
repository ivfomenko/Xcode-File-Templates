//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Quick
import Nimble
import RxSwift
import RxCocoa
@testable import ___PROJECTNAME___

// MARK: - ___VARIABLE_sceneName___PresenterTests
class ___VARIABLE_sceneName___PresenterTests: QuickSpec {
    override func spec() {
        describe("Cases") {
            var tested_presenter: ___VARIABLE_sceneName___PresenterImpl!
            var interactor: MockInteractor!
            var router: MockNavigation!
        }
    }
}

// MARK: - MockInteractor: ___VARIABLE_sceneName___Interactor
private class MockInteractor: ___VARIABLE_sceneName___Interactor {
    
}

// MARK: - MockNavigation: ___VARIABLE_sceneName___Navigation
private class MockNavigation: ___VARIABLE_sceneName___Navigation {
    
}

// MARK: - MockNavigation: ___VARIABLE_sceneName___Navigation + Action
private extension MockNavigation {
    /// Navigation actions for tests
    enum Action {

    }
}

// MARK: - MokeTransition
private class MockTransition: Transition {
    
    var viewController: UIViewController?
    
    var completionHandler: (() -> Void)?
    
    func open(_ viewController: UIViewController) {}
    
    func close(_ viewController: UIViewController) {}
}