//
//  WMJPresentationController.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/30.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class WMJPresentationController: UIPresentationController {
    /*
    1.如果不自定义转场modal出来的控制器会移除原有的控制器
    2.如果自定义转场modal出来的控制器不会移除原有的控制器
    3.如果不自定义转场modal出来的控制器的尺寸和屏幕一样
    4.如果自定义转场modal出来的控制器的尺寸我们可以自己在containerViewWillLayoutSubviews方法中控制
    5.containerView 非常重要, 容器视图, 所有modal出来的视图都是添加到containerView上的
    6.presentedView() 非常重要, 通过该方法能够拿到弹出的视图
    */
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    // 用于布局转场动画弹出的控件
    override func containerViewWillLayoutSubviews() {

        
        // 设置弹出视图的尺寸
        presentedView()?.frame = CGRect(x: 100, y: 45, width: 200, height: 200)
        
        containerView?.insertSubview(backgroundButton, atIndex: 0)
        backgroundButton.addTarget(self, action: Selector("clickedBackgroundBtn"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    @objc private func clickedBackgroundBtn(){
        WMJLog("btnClicked!")
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private lazy var backgroundButton:UIButton = {
        let btn = UIButton()
        btn.frame = UIScreen.mainScreen().bounds
        btn.backgroundColor = UIColor.clearColor()
        return btn
    }()
    
    
}
