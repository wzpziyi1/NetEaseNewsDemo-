//
//  ZYMainNavigationController.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ZYMainNavigationController: UINavigationController {

    //重写这个方法，设置统一的导航栏主题
    override class func initialize(){
        let appearance = UINavigationBar.appearance()
        appearance.setBackgroundImage(UIImage(named: "top_navigation_background"), forBarMetrics: UIBarMetrics.Default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //使用kvc，替换掉系统的navigationBar（系统的navigationBar是readOnly的）
        self.setValue(ZYNavigationBar(), forKeyPath: "navigationBar")
    }
    
}
