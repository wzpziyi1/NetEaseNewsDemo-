//
//  ZYImageExtension.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

extension UIImage {

    class func imageWithColor(color: UIColor) ->UIImage {
        let imageW: CGFloat = 100
        let imageH: CGFloat = 100
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), false, 0)
        color.set()
        UIRectFill(CGRectMake(0, 0, imageW, imageH))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
}
