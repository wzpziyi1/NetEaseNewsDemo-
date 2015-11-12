//
//  CWBarStyleUtils.swift
//  HealthRoom
//
//  Created by 王志盼 on 15/7/17.
//  Copyright (c) 2015年 criwell. All rights reserved.
//

import UIKit

class CWBarStyleUtils {
    class func barStyle(statusBarColor:UIColor, navigationBarImage:String, viewController:UIViewController){
        let statusView : UIView! = UIView(frame: CGRectMake(0, -20, UIScreen.mainScreen().bounds.width, 20));
        statusView.backgroundColor = statusBarColor;
        viewController.navigationController!.navigationBar.addSubview(statusView);
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false);
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: navigationBarImage), forBarMetrics: UIBarMetrics.Default);
    }
}
