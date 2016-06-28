//
//  MainViewController.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/28.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildviewControllers()
    }

    func addChildviewControllers()->Void{
        
        //通过传入类创建
//        addChildViewController(HomeTableViewController(), title: "首页", imageName:"tabbar_home" )
//        
//        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
//        
//        addChildViewController(DiscoverTableViewController(), title: "广场", imageName: "tabbar_discover")
//        
//        addChildViewController(MessageTableViewController(), title: "我", imageName: "tabbar_profile")
        
        //通过字符串创建
        addChildViewController("HomeTableViewController", title: "首页", imageName:"tabbar_home" )

        addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")

        addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")

        addChildViewController("MessageTableViewController", title: "我", imageName: "tabbar_profile")
        
    }

//    func addChildViewController(childController: UITableViewController,title:String,imageName:String) {
    func addChildViewController(childControllerString: String,title:String,imageName:String) {
        
        //获取命名空间，一个项目的命名空间就是该项目的名称
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let classNameStr = nameSpace + "." + childControllerString
        let cls:AnyClass =  NSClassFromString(classNameStr)!
        
        let clsClass = cls as!UITableViewController.Type
        
        let childController = clsClass.init()
        
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.image = UIImage(named: imageName+"_highlighted")
        tabBar.tintColor = UIColor.orangeColor()
        let nav:UINavigationController = UINavigationController(rootViewController: childController)
        
        addChildViewController(nav)
        
       WMJLog(title)
    }
    
}
