import XCTest
@testable import ___PROJECTNAME___

// MARK: - ___VARIABLE_sceneName___PresenterTests: XCTestCase
final class ___VARIABLE_sceneName___PresenterTests: XCTestCase {
    
    // MARK: - Init Block
    var sut: ___VARIABLE_sceneName___Presenter!

    override func setUp() {
        super.setUp()
        self.startInit()
    }
    
    override func tearDown() {
        self.endClean()
        super.tearDown()
    }
    
    private func startInit() {
        self.sut = .init()
    }
    
    private func endClean() {
        self.sut = nil
    }
    
    // MARK: - Tests
}