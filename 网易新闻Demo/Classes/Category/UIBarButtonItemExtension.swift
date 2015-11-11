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
    
    class func barButtonWithImage(normalImageName:String, highImageName:String, action:Selector, target:AnyObject)-> UIBarButtonItem{
        let bnt = UIButton();
        bnt.setBackgroundImage(UIImage(named: normalImageName), forState: UIControlState.Normal)
        bnt.setBackgroundImage(UIImage(named: highImageName), forState: UIControlState.Highlighted);
        bnt.frame = CGRectMake(0, 0, bnt.currentBackgroundImage!.size.width, bnt.currentBackgroundImage!.size.height);
        bnt.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside);
        return UIBarButtonItem(customView: bnt);
    }
    
    class func barButtonWithTitle(normalTitle:String, highTitle:String, action:Selector, target:AnyObject)-> UIBarButtonItem{
        let bnt = UIButton();
        bnt.titleLabel!.textAlignment = NSTextAlignment.Center;
        bnt.setTitle(normalTitle, forState: UIControlState.Normal);
        bnt.setTitle(highTitle, forState: UIControlState.Highlighted);
        bnt.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        bnt.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled);
        bnt.frame = CGRectMake(0, 0, 44, 44);
        bnt.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside);
        return UIBarButtonItem(customView: bnt);
    }
    
    class func barButtonItem(normalImage:String, highlightImage:String, target:AnyObject, action:Selector) ->UIBarButtonItem{
        let bnt = UIButton();
        bnt.setBackgroundImage(UIImage(named: normalImage), forState: UIControlState.Normal)
        bnt.setBackgroundImage(UIImage(named: highlightImage), forState: UIControlState.Highlighted);
        bnt.frame = CGRectMake(0, 0, bnt.currentBackgroundImage!.size.width, bnt.currentBackgroundImage!.size.height);
        bnt.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside);
        return UIBarButtonItem(customView: bnt) as UIBarButtonItem;
    }
    
}
