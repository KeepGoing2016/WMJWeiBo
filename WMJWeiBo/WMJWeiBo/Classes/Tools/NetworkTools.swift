//
//  NetworkTools.swift
//  WMJWeiBo
//
//  Created by lumf on 16/7/7.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit
import AFNetworking
// Swift推荐我们这样编写单例
class NetworkTools: AFHTTPSessionManager {
    static let shareInstance:NetworkTools = {
        let baseURL = NSURL(string: "https://api.weibo.com")
        let instance = NetworkTools(baseURL: baseURL, sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        instance.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain") as? Set
        return instance
    }()
}
