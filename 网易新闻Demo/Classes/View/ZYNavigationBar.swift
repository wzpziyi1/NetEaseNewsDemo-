//
//  ZYNavigationBar.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ZYNavigationBar: UINavigationBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for (var i = 0; i < self.subviews.count; i++){
            let btn = self.subviews[i]
            
            if (btn.isKindOfClass(UIButton.self)) {
                if (btn.center.x < self.frame.width * 0.5) {
                    btn.frame.origin.x = 0
                }
                else if (btn.center.x > self.frame.width * 0.5) {
                    btn.frame.origin.x = self.frame.width - btn.frame.width
                }
            }
        }
    }
}
