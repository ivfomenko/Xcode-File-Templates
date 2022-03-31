//
//
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import UIKit

protocol Transition: class {
    var viewController: UIViewController? { get set }

    var completionHandler: (() -> Void)? { get set }
    
    func open(vc: UIViewController, completion: (() -> Void)?)
    func close(vc: UIViewController, completion: (() -> Void)?)
    func pop(vc: UIViewController, completion: (() -> Void)?)
    func pop(to: AppStoryboards, vc: UIViewController, completion: (() -> Void)?)
    func root(vc: UIViewController, completion: (() -> Void)?)
}

extension Transition {
    
    func open(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        self.open(vc: viewController, completion: completion)
    }
    
    func close(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        self.close(vc: viewController, completion: completion)
    }
    
    func pop(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        self.pop(vc: viewController, completion: completion)
    }
    
    func pop(to: AppStoryboards, _ viewController: UIViewController, completion: (() -> Void)? = nil) {
        self.pop(to: to, vc: viewController, completion: completion)
    }
    
    func root(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        self.root(vc: viewController, completion: completion)
    }
}
