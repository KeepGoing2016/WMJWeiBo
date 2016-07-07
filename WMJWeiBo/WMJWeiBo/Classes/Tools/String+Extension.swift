//
//  String+Extension.swift
//  WMJWeiBo
//
//  Created by lumf on 16/7/6.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

extension String{
    func cachesDir() ->String{
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last
        let name = (self as NSString).lastPathComponent
        
        return (path! as NSString).stringByAppendingPathComponent(name)
        
    }
    
    func documentDir() ->String{
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last
        let name = (self as NSString).lastPathComponent
        return (path! as NSString).stringByAppendingPathComponent(name)
    }
    
    func tempDir() ->String {
        let path = NSTemporaryDirectory()
        let name = (self as NSString).lastPathComponent
        return (path as NSString).stringByAppendingPathComponent(name)
    }
}
