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
        
    }

}
