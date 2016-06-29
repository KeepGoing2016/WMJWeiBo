//
//  MeTableViewController.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/28.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class MeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupVisitorInfo("登录后，你的微博、相册、个人资料会显示在这里，展示给别人", centerImage: "visitordiscover_image_profile")
    }


}
