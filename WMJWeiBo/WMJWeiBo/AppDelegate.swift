//
//  AppDelegate.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/27.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
//        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        let vc = MainViewController()
//        vc.view.backgroundColor = UIColor.redColor()
//        window?.rootViewController = vc
//        window?.makeKeyAndVisible()
        return true
    }

    

}

func WMJLog<T>(message:T ,method:String = __FUNCTION__,line:Int = __LINE__){
    #if DEBUG
        print("\(message)---\(method)---\(line)")
    #endif
}