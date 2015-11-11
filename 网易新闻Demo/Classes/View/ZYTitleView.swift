//
//  ZYTitleView.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ZYTitleView: UIView {

    var title: String! {
        didSet{
            self.btn.setTitle(title, forState: UIControlState.Normal)
        }
    }
    
    weak var btn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commitInit()
    }
    
    private func commitInit() {
//        self.backgroundColor = kRandomColor()
        let btn = UIButton()
        btn.adjustsImageWhenHighlighted = false
        btn.titleLabel?.font = UIFont.boldSystemFontOfSize(21)
        btn.setImage(UIImage(named: "navbar_netease"), forState: UIControlState.Normal)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.addSubview(btn)
        self.btn = btn
        btn.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        print(btn.frame)
    }
}