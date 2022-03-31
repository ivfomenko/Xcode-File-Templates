//
//
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

class PushTransition: NSObject {

    var animator: AnimatorProtocol?
    var isAnimated: Bool = true
    var completionHandler: (() -> Void)?

    weak var viewController: UIViewController?

    init(animator: AnimatorProtocol? = nil, isAnimated: Bool = true) {
        self.animator = animator
        self.isAnimated = isAnimated
    }
    
    override init() {}
}

// MARK: - Transition

extension PushTransition: Transition {
    
    func open(vc: UIViewController, completion: (() -> Void)?) {
        self.viewController?.navigationController?.delegate = self
        self.viewController?.navigationController?.pushViewController(vc, animated: isAnimated)
    }
    
    func close(vc: UIViewController, completion: (() -> Void)?) {
        vc.navigationController?.popViewController(animated: isAnimated)
    }
    
    func pop(vc: UIViewController, completion: (() -> Void)?) {
        vc.navigationController?.popViewController(animated: isAnimated)
    }
    
    func root(vc: UIViewController, completion: (() -> Void)?) {
        vc.navigationController?.popToRootViewController(animated: isAnimated)
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

extension PushTransition: UINavigationControllerDelegate {

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
