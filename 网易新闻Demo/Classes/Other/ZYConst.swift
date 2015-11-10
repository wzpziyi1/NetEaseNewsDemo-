//
//  ZYConst.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit
import Foundation
/**
*   替代oc中的#define
*/
// 屏幕的物理宽度
let kScreenWidth = UIScreen.mainScreen().bounds.size.width
// 屏幕的物理高度
let kScreenHeight = UIScreen.mainScreen().bounds.size.height
/**
 *   除了一些简单的属性直接用常量表达,更推荐用全局函数来定义替代宏
 */
 // 判断系统版本
func kIS_IOS7() ->Bool { return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0 }
func kIS_IOS8() -> Bool { return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0 }
func KIS_IOS9() -> Bool { return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 9.0 }
// RGBA的颜色设置
func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//随机颜色
func kRandomColor() ->UIColor {
    let r = arc4random_uniform(256)
    let g = arc4random_uniform(256)
    let b = arc4random_uniform(256)
    return kRGBA(CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: 1.0)
}


