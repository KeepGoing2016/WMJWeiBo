//
//  MessageTableViewController.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/28.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class MessageTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogin {
        
            visitorView?.setupVisitorInfo("登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", centerImage: "visitordiscover_image_message")
        }
    }

   
}
