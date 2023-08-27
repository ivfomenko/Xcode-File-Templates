//
//
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit

extension UIWindow {
    
    func switchRootViewController(_ viewController: UIViewController, animated: Bool = true, duration: TimeInterval = 0.35, options: UIView.AnimationOptions = .transitionCrossDissolve, completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
}

class RootTransition: NSObject {
    
    var animator: AnimatorProtocol?
    var isAnimated: Bool = true
    
    var modalTransitionStyle: UIModalTransitionStyle
    var modalPresentationStyle: UIModalPresentationStyle
    
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
    
}

// MARK: - Transition

extension RootTransition: Transition {
    
    func open(vc: UIViewController, completion: (() -> Void)?) {
        vc.transitioningDelegate = self
        vc.modalTransitionStyle = modalTransitionStyle
        vc.modalPresentationStyle = modalPresentationStyle
        
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.switchRootViewController(vc)
        mainWindow?.rootViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func close(vc: UIViewController, completion: (() -> Void)?) {}
    func pop(vc: UIViewController, completion: (() -> Void)?) {}
    func root(vc: UIViewController, completion: (() -> Void)?) {}
    func pop(to: AppStoryboards, vc: UIViewController, completion: (() -> Void)?) {}
}

// MARK: - UIViewControllerTransitioningDelegate

extension RootTransition: UIViewControllerTransitioningDelegate {
    
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
