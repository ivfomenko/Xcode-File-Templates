//
//
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

class ClosablePushTransition: NSObject {

    var animator: AnimatorProtocol?
    var isAnimated: Bool = true
    var completionHandler: (() -> Void)?

    weak var viewController: UIViewController?
    weak var closeTargetViewController: UIViewController?

    init(closeTargetViewController: UIViewController?, animator: AnimatorProtocol? = nil, isAnimated: Bool = true) {
        self.closeTargetViewController = closeTargetViewController
        self.animator = animator
        self.isAnimated = isAnimated
    }
}

// MARK: - Transition

extension ClosablePushTransition: Transition {

    func open(vc: UIViewController, completion: (() -> Void)?) {
        self.viewController?.navigationController?.delegate = self
        self.viewController?.navigationController?.pushViewController(vc, animated: isAnimated)
    }

    func close(vc: UIViewController, completion: (() -> Void)?) {
        guard let target = closeTargetViewController else {
            vc.navigationController?.popViewController(animated: true)
            return
        }
        vc.navigationController?.popToViewController(target, animated: true)
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

extension ClosablePushTransition: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        completionHandler?()
    }

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
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
