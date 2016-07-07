//
//  WMJPoperTransitionManager.swift
//  WMJWeiBo
//
//  Created by lumf on 16/7/1.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit


class WMJPoperTransitionManager: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    
    var isDismiss = false
    
    var poperframe = CGRectZero
    
    //MARK:-转场动画UIViewControllerTransitioningDelegate
    // 该方法用于返回一个负责转场动画的对象
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        let pc = WMJPresentationController(presentedViewController: presented, presentingViewController: presenting)
        pc.poperframe = poperframe
        return pc
    }
    
    // 返回控制转场动画特效的类
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isDismiss = false
        NSNotificationCenter.defaultCenter().postNotificationName(WMJTransitionManagerDidDismiss, object: nil)
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isDismiss = true
        NSNotificationCenter.defaultCenter().postNotificationName(WMJTransitionManagerDidDismiss, object: nil)
        return self
    }

//MARK:-转场过度效果UIViewControllerAnimatedTransitioning
    //暂时没有用
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        if !isDismiss {
            startAnimation(transitionContext)
        } else{
            dismissAnimation(transitionContext)
        }
        
    }
    
    private func startAnimation(transitionContext: UIViewControllerContextTransitioning){
        guard let toView = transitionContext.viewForKey(UITransitionContextToViewKey) else{
            return
        }
        //       let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        transitionContext.containerView()?.addSubview(toView)
        toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            toView.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                transitionContext.completeTransition(true)
 
        }
    }
    
    private func dismissAnimation(transitionContext: UIViewControllerContextTransitioning){
        guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) else{
            return
        }
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            // 突然消失的原因: CGFloat不准确, 导致无法执行动画, 遇到这样的问题只需要将CGFloat的值设置为一个很小的值即可
            fromView.transform = CGAffineTransformMakeScale(1.0, 0.00001)
            }, completion: { (_) -> Void in
                transitionContext.completeTransition(true)
        })
    }

}
