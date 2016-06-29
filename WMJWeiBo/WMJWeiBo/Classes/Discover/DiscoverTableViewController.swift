//
//  DiscoverTableViewController.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/28.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class DiscoverTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupVisitorInfo("登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过", centerImage: "visitordiscover_image_message")
    }


}
