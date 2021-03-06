//
//  BaseTableViewController.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/29.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var isLogin = UserAccount.isLogin()
    
    var visitorView:VisitorView?
    
    override func loadView() {
        
        
        isLogin ? super.loadView():setupVisitorView()
    }
    
    func setupVisitorView(){
        visitorView = VisitorView.visitorView()
        view = visitorView
        
        visitorView?.loginButton.addTarget(self, action: Selector("userLogin"), forControlEvents: UIControlEvents.TouchUpInside)
        visitorView?.registerButton.addTarget(self, action: Selector("userRegister"), forControlEvents: UIControlEvents.TouchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("userRegister"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("userLogin"))
        
    }
    
    func userLogin(){
        let sb = UIStoryboard(name: "OAuth", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        presentViewController(vc!, animated: true, completion: nil)
    }
    
    func userRegister(){
        WMJLog("registerClicked!")
    }

}
