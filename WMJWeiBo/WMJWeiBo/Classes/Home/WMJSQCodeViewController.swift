//
//  WMJSQCodeViewController.swift
//  WMJWeiBo
//
//  Created by lumf on 16/7/1.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class WMJSQCodeViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var customBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customBar.selectedItem = customBar.items?.first
        customBar.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        startAnimation()
    }

    private func startAnimation(){
        topConstraint.constant = -heightConstraint.constant
        view.layoutIfNeeded()
        UIView.animateWithDuration(2.0) { () -> Void in
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.topConstraint.constant = self.heightConstraint.constant
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func intoPhotos(sender: AnyObject) {
        WMJLog("进入相册")
    }

}

extension WMJSQCodeViewController:UITabBarDelegate{
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        heightConstraint.constant = item.title == "二维码" ? 300:150
        
//        view.layoutIfNeeded()
        
        view.layer.removeAllAnimations()
        
        startAnimation()
        
    }
}