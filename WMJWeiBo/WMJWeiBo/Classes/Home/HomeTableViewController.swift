//
//  HomeTableViewController.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/28.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogin{
            visitorView?.setupVisitorInfo("关注一些人，回这里看看有什么惊喜", centerImage: nil)
            return
        }
        
        setupNav()
        
    }
    
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: Selector("clickedLeftBtn"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: Selector("clickedRightBtn"))
        
        let titleView = TitleButton()
        titleView.setTitle("小曼君", forState: UIControlState.Normal)
        titleView.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        titleView.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        titleView.addTarget(self, action: Selector("clickedTitle:"), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView = titleView
    }
    
    @objc private func clickedLeftBtn(){
        WMJLog("left")
    }
    
    @objc private func clickedRightBtn(){
        WMJLog("right")
    }
    
    @objc private func clickedTitle(titleView:TitleButton){
        titleView.selected = !titleView.selected
        
        guard let menuVC = UIStoryboard(name: "HomeMenu", bundle: nil).instantiateInitialViewController() else{
            return
        }
        
        
        menuVC.transitioningDelegate = self
        menuVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        presentViewController(menuVC, animated: true, completion: nil)
    }
    
    var isDismiss = false

}

//MARK:-转场动画
extension HomeTableViewController:UIViewControllerTransitioningDelegate{
    // 该方法用于返回一个负责转场动画的对象
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        return WMJPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    // 返回控制转场动画特效的类
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isDismiss = false
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isDismiss = true
        return self
    }
}

extension HomeTableViewController:UIViewControllerAnimatedTransitioning{
    //暂时没有用
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        if !isDismiss {
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
        } else{
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
}
