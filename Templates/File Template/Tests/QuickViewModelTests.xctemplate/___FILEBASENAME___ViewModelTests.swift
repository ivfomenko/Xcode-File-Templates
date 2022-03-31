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

// MARK: - ___VARIABLE_sceneName___ViewModelTests
class ___VARIABLE_sceneName___ViewModelTests: QuickSpec {
    override func spec() {
        describe("Cases") {
            var tested_presenter: ___VARIABLE_sceneName___ViewModel!
            var repository: MockRepository!
            var router: MockRouter!
        }
    }
}

// MARK: - MockRepository: ___VARIABLE_sceneName___Repository
private class MockRepository: ___VARIABLE_sceneName___Repository {
    
}

// MARK: - MockRouter: ___VARIABLE_sceneName___Navigation
private class MockRouter: ___VARIABLE_sceneName___Navigation {
    
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
