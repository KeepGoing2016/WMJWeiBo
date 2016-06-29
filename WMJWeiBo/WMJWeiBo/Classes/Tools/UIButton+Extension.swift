//
//  UIButton+Extension.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/29.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

extension UIButton
{
    convenience init(foreImage:String,backgroundImage:String){
        self.init()
        
        setImage(UIImage(named: foreImage), forState: UIControlState.Normal)
        setImage(UIImage(named: foreImage+"_highlighted"), forState: UIControlState.Highlighted)
        
        setBackgroundImage(UIImage(named: backgroundImage), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backgroundImage+"_highlighted"), forState: UIControlState.Highlighted)
        
        sizeToFit()
    }
}