//
//  ZYAdvertViewController.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/10.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ZYAdvertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupBackgroundView()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
            let window = UIApplication.sharedApplication().keyWindow
            window?.rootViewController = ZYMainViewController()
        }
    }

//MARK:- setup系列
    
    private func setupBackgroundView() {
        let bgView = UIImageView()
        bgView.image = UIImage(named: "Default")
        self.view.addSubview(bgView)
        bgView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        
        let label = UILabel(frame: CGRectMake(50, 50, 200, 100))
        label.text = "这是一个广告界面"
        self.view.addSubview(label)
        
    }
}
