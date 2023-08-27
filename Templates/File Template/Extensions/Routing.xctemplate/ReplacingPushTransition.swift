//
//
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import UIKit

class ReplacingPushTransition: NSObject {

    var animator: AnimatorProtocol?
    var isAnimated: Bool = true
    var completionHandler: (() -> Void)?

    weak var viewController: UIViewController?

    init(animator: AnimatorProtocol? = nil, isAnimated: Bool = true) {
        self.animator = animator
        self.isAnimated = isAnimated
    }
    
    deinit {
        logger.debug("⚔️ deinit \(String(describing: self))")
    }
}

// MARK: - Transition

extension ReplacingPushTransition: Transition {

    func open(vc: UIViewController, completion: (() -> Void)?) {
        self.viewController?.navigationController?.delegate = self
        // it's replacing transition - so we need to get previos last, remove it and after it replace navigation stack with new list of viewcontroller without it
        guard var viewControllers = self.viewController?.navigationController?.viewControllers else {
            self.viewController?.navigationController?.pushViewController(vc, animated: isAnimated)
            return
        }
        _ = viewControllers.popLast()

        // Push targetViewController
        viewControllers.append(vc)
        self.viewController?.navigationController?.setViewControllers(viewControllers, animated: true)
    }

    func close(vc: UIViewController, completion: (() -> Void)?) {
        vc.navigationController?.popViewController(animated: isAnimated)
    }
    
    func pop(vc: UIViewController, completion: (() -> Void)?) {
        vc.navigationController?.popViewController(animated: true)
    }
    
    func root(vc: UIViewController, completion: (() -> Void)?) {
        vc.navigationController?.popToRootViewController(animated: true)
    }
    
    func pop(to: AppStoryboards, vc: UIViewController, completion: (() -> Void)?) {
        if let target = vc.navigationController?.viewControllers.first(where: { target -> Bool in
            return target.restorationIdentifier == to.restorationIdentifier
        }) {
            vc.navigationController?.popToViewController(target, animated: isAnimated)
        } else {
            vc.navigationController?.popToRootViewController(animated: isAnimated)
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension ReplacingPushTransition: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        completionHandler?()
    }

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return nil
        default:
            guard let animator = animator else {
                return nil
            }
            if operation == .push {
                animator.isPresenting = true
                return animator
            } else {
                animator.isPresenting = false
                return animator
            }
        }
        
    }
}
