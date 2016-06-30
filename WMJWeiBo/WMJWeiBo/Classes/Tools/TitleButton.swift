//
//  TitleButton.swift
//  WMJWeiBo
//
//  Created by lumf on 16/6/29.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

//    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
//        
//    }

//    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
//        <#code#>
//    }
    // 通过纯代码创建时调用
    // 在Swift中如果重写父类的方法, 必须在方法前面加上override
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    // 通过XIB/SB创建时调用
    required init?(coder aDecoder: NSCoder) {
        // 系统对initWithCoder的默认实现是报一个致命错误
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
//        super.setTitle(title! + " ", forState: state)
        super.setTitle((title ?? "") + " ", forState: state)
    }
    
    private func setupUI(){
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /*
        // offsetInPlace 方法用于设置控件的偏移位
        titleLabel?.frame.offsetInPlace(dx: -imageView!.frame.width * 0.5, dy: 0)
        imageView?.frame.offsetInPlace(dx: titleLabel!.frame.width * 0.5, dy: 0)
        */
        
        // 和OC不太一样, Swift语法允许我们直接修改一个对象的结构体属性的成员
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)!
    }
}
