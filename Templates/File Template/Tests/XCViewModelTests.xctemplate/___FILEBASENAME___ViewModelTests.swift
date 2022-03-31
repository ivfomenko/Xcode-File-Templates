//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import XCTest
import RxSwift
@testable import ___PROJECTNAME___

// MARK: - ___VARIABLE_sceneName___ViewModelTests: XCTestCase
class ___VARIABLE_sceneName___ViewModelTests: XCTestCase {
    // MARK: - Init Block
    var viewModel: ___VARIABLE_sceneName___ViewModel!
    var navigation:  MockNavigation!
    var repository: MockRepository!
    
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        self.startInit()
    }
    
    override func tearDown() {
        self.endClean()
        super.tearDown()
    }
    
    private func startInit() {
        self.viewModel = ___VARIABLE_sceneName___ViewModel(router: navigation, repository: repository)
    }
    
    private func endClean() {
        self.viewModel = nil
    }
    
    // MARK: - Tests
}

// MARK: - Mock___VARIABLE_sceneName___Repository: ___VARIABLE_sceneName___Repository
private class Mock___VARIABLE_sceneName___Repository: ___VARIABLE_sceneName___Repository {
    
}

// MARK: - Mock___VARIABLE_sceneName___Navigation: ___VARIABLE_sceneName___Navigation
private class MockNavigation: Router<___VARIABLE_sceneName__ViewController>, ___VARIABLE_sceneName___Navigation {
    
}

// MARK: - MockNavigation: ___VARIABLE_sceneName___Navigation + Action
private extension MockNavigation {
    /// Navigation actions for tests
    enum Action {

    }
}

// MARK: - MockTransition
private class MockTransition: Transition {
    
    var viewController: UIViewController?
    
    var completionHandler: (() -> Void)?
    
    func open(_ viewController: UIViewController) {}
    
    func close(_ viewController: UIViewController) {}
}
