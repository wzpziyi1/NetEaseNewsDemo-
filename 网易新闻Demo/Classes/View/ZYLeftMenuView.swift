//
//  ZYLeftMenuView.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

@objc protocol ZYLeftMenuViewDelegate: NSObjectProtocol{
    optional func leftMenuView(leftMenuView: ZYLeftMenuView, didClickButtonAtIndex index: Int)
}

class ZYLeftMenuView: UIView {

    class ZYButton: UIButton {
        override var highlighted: Bool {
            set{
                
            }
            get{
                return super.highlighted
            }
        }
    }
    
    weak var selectedBtn: ZYButton?
    weak var delegate: ZYLeftMenuViewDelegate? {
        didSet{
            self.clickButton(self.subviews[0] as! ZYButton)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commitInit()
    }
    
    private func commitInit() {
        self.backgroundColor = UIColor.clearColor()
        let alpha: CGFloat = 0.2
        buttonWithTitle("新闻", imageName: "sidebar_nav_news", color: kRGBA(202, g: 68, b: 73, a: alpha))
        buttonWithTitle("订阅", imageName: "sidebar_nav_reading", color: kRGBA(190, g: 111, b: 69, a: alpha))
        buttonWithTitle("图片 ", imageName: "sidebar_nav_photo", color: kRGBA(76, g: 132, b: 190, a: alpha))
        buttonWithTitle("视频", imageName: "sidebar_nav_video", color: kRGBA(101, g: 170, b: 78, a: alpha))
        buttonWithTitle("跟帖", imageName: "sidebar_nav_comment", color: kRGBA(170, g: 172, b: 73, a: alpha))
        buttonWithTitle("电台", imageName: "sidebar_nav_radio", color: kRGBA(190, g: 62, b: 119, a: alpha))
        
    }
    
    private func buttonWithTitle(title: String, imageName: String, color: UIColor) {
        let btn = ZYButton(type: UIButtonType.Custom)
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage.imageWithColor(color), forState: UIControlState.Selected)
        btn.addTarget(self, action: Selector("clickButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //设置内容左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        btn.tag = self.subviews.count
        
        self.addSubview(btn)
    }

    func clickButton(btn: ZYButton) {
        self.selectedBtn?.selected = false
        self.selectedBtn = self.subviews[btn.tag] as? ZYButton
        self.selectedBtn?.selected = true
        
        if ((self.delegate?.respondsToSelector(Selector("leftMenuView: didClickButtonAtIndex:"))) != nil) {
            self.delegate!.leftMenuView!(self, didClickButtonAtIndex: self.selectedBtn!.tag)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let h = self.frame.height / CGFloat(self.subviews.count)
        let w = self.frame.width
        
        for (var i = 0; i < self.subviews.count; i++) {
            let btn = self.subviews[i]
            btn.frame = CGRectMake(0, h * CGFloat(i), w, h)
        }
    }
}
