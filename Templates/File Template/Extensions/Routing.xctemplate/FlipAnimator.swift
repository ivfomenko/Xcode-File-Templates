//
//
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import UIKit

final class FlipAnimator: NSObject, AnimatorProtocol {
    
    init(flipDirection: FlipDirection) {
        self.flipDirection = flipDirection
        super.init()
    }
    
    enum FlipDirection {
        case fromLeft
        case fromRight
        case fromTop
        case fromBottom
        
        fileprivate var animationOption: UIView.AnimationOptions {
            switch self {
            case .fromBottom:
                return .transitionFlipFromBottom
            case .fromLeft:
                return .transitionFlipFromLeft
            case .fromRight:
                return .transitionFlipFromRight
            case .fromTop:
                return .transitionFlipFromTop
            }
        }
    }
    
    var isPresenting: Bool = true
    let flipDirection: FlipDirection
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        animate(transitionContext: transitionContext)
    }
    
    private func animate(transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toView = toViewController.view,
            let fromView = fromViewController.view else {
            return
        }
        
        toView.isHidden = true
        transitionContext.containerView.addSubview(fromView)
        transitionContext.containerView.addSubview(toView)
        
        UIView.transition(from: fromView,
                          to: toView,
                          duration: transitionDuration(using: transitionContext),
                          options: [.showHideTransitionViews, self.flipDirection.animationOption],
                          completion: { _ in
                            transitionContext.completeTransition(true)
        })
    }
}
