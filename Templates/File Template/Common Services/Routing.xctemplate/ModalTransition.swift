//
//
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

class ModalTransition: NSObject {

    var animator: AnimatorProtocol?
    var isAnimated: Bool = true

    var modalTransitionStyle: UIModalTransitionStyle = .coverVertical
    var modalPresentationStyle: UIModalPresentationStyle = .fullScreen

    var completionHandler: (() -> Void)?

    weak var viewController: UIViewController?

    init(animator: AnimatorProtocol? = nil,
         isAnimated: Bool = true,
         modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
         modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        self.animator = animator
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
    }
    
    override init() {}
}

// MARK: - Transition

extension ModalTransition: Transition {

    func open(vc: UIViewController, completion: (() -> Void)?) {
        vc.transitioningDelegate = self
        vc.modalTransitionStyle = modalTransitionStyle
        vc.modalPresentationStyle = modalPresentationStyle

        self.viewController?.present(vc, animated: isAnimated, completion: completionHandler)
    }

    func close(vc: UIViewController, completion: (() -> Void)?) {
        vc.dismiss(animated: isAnimated, completion: completion)
    }
    
    func pop(vc: UIViewController, completion: (() -> Void)?) {
        vc.dismiss(animated: isAnimated, completion: completion)
    }
    
    func root(vc: UIViewController, completion: (() -> Void)?) {
        vc.dismiss(animated: isAnimated, completion: completion)
    }
    
    func pop(to: AppStoryboards, vc: UIViewController, completion: (() -> Void)?) {
        vc.dismiss(animated: isAnimated, completion: completion)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension ModalTransition: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = true
        return animator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = false
        return animator
    }
}
