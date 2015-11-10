//
//  UIBarButtonItemExtension.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    class func barButtonItemWithTarget(target: AnyObject, action: Selector, imageName: String) ->UIBarButtonItem
    {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.frame.size = (btn.currentImage?.size)!
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
//        print(btn.frame)
        return UIBarButtonItem(customView: btn)
    }
}
