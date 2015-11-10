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

"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo.xcodeproj/xcuserdata/wangzhipan1.xcuserdatad/xcdebugger/"

"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/pluginboard_icon_add.imageset/pluginboard_icon_add@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/pluginboard_icon_comment.imageset/pluginboard_icon_comment@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/pluginboard_icon_favor.imageset/pluginboard_icon_favor@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/pluginboard_icon_mailbox.imageset/pluginboard_icon_mailbox@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/pluginboard_icon_message.imageset/pluginboard_icon_message@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/pluginboard_icon_night.imageset/pluginboard_icon_night@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/pluginboard_icon_offline.imageset/pluginboard_icon_offline@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/pluginboard_icon_search.imageset/pluginboard_icon_search@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/pluginboard_icon_weather.imageset/pluginboard_icon_weather@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/promoboard_icon_activities.imageset/promoboard_icon_activities@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/promoboard_icon_apps.imageset/promoboard_icon_apps@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/promoboard_icon_mall.imageset/promoboard_icon_mall@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/setting_icon.imageset/setting_icon@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/settingcell_arrow.imageset/settingcell_arrow@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Plugin/user_defaultgift.imageset/user_defaultgift@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Sidebar/Default.imageset/Default-568h@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Sidebar/Default.imageset/Default.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Sidebar/Default.imageset/Default@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Sidebar/sidebar_ad_arrow.imageset/sidebar_ad_arrow@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Sidebar/sidebar_nav_comment.imageset/sidebar_nav_comment@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Sidebar/sidebar_nav_news.imageset/sidebar_nav_news@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Sidebar/sidebar_nav_photo.imageset/sidebar_nav_photo@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Sidebar/sidebar_nav_radio.imageset/sidebar_nav_radio@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Sidebar/sidebar_nav_reading.imageset/sidebar_nav_reading@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/Sidebar/sidebar_nav_video.imageset/sidebar_nav_video@2x.png"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/sidebar_bg.imageset/"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Assets.xcassets/sidebar_bg@2x.jpg"
"/Users/wangzhipan1/Desktop/oc程序/Swift练手/网易新闻Demo/网易新闻Demo/Classes/Other/AppDelegate.swift"