//
//  VisitorView.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/29.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    @IBOutlet weak var circleView: UIImageView!
    
    @IBOutlet weak var descLable: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    
     class func visitorView()->VisitorView{
       
     return  NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil).last as! VisitorView
    }
    
    func setupVisitorInfo(title:String,centerImage:String?){
        descLable.text = title;
        guard let image = centerImage else {
            startAnimation()
            return
        }
        circleView.hidden = true
        iconImage.image = UIImage(named: image)
    }

    private func startAnimation(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 5
        // 注意: 默认情况下只要视图消失, 系统就会自动移除动画
        // 只要设置removedOnCompletion为false, 系统就不会移除动画
        anim.removedOnCompletion = false
        
        circleView.layer.addAnimation(anim, forKey: nil)
    }
}
