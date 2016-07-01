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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("titleChange"), name: WMJTransitionManagerDidPresent, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("titleChange"), name: WMJTransitionManagerDidDismiss, object: nil)
    }
    
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: Selector("clickedLeftBtn"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: Selector("clickedRightBtn"))
        navigationItem.titleView = titleView
        
        
    }
    
    private lazy var titleView:TitleButton = {
        let title = TitleButton()
        title.setTitle("小曼君", forState: UIControlState.Normal)
        title.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        title.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        title.addTarget(self, action: Selector("clickedTitle"), forControlEvents: UIControlEvents.TouchUpInside)
        return title
    }()
    
    @objc private func clickedLeftBtn(){
        WMJLog("left")
    }
    
    @objc private func clickedRightBtn(){
        let sb = UIStoryboard(name: "SQCode", bundle: nil)
        guard let codeVC = sb.instantiateInitialViewController() else{
            return
        }
        presentViewController(codeVC, animated: true, completion: nil)
    }
    
    @objc private func titleChange(){
        titleView.selected = !titleView.selected
    }
    
    @objc private func clickedTitle(){
        
        
        guard let menuVC = UIStoryboard(name: "HomeMenu", bundle: nil).instantiateInitialViewController() else{
            return
        }
        
        
        menuVC.transitioningDelegate = animatorManager
        menuVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        presentViewController(menuVC, animated: true, completion: nil)
    }
    
    private lazy var animatorManager:WMJPoperTransitionManager={
        let manager = WMJPoperTransitionManager()
        manager.poperframe = CGRect(x:110, y: 64, width: 200, height: 300)
        return manager
    }()

}

