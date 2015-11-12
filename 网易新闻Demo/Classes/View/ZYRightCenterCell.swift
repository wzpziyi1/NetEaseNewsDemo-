//
//  ZYRightCenterCell.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/11.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ZYRightCenterCell: UITableViewCell {

    /// 类成员，需要注意的是，类属性只能是计算属性，也就是说，必须写get\set方法之一或者全部，在对象调用的时候，可以这么调用：ZYRightCenterCell.identifier
    class var identifier: String {
        get{
            return "ZYRightCenterCell"
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commitInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.commitInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func creatRightCenterCellWithTableView(tableView: UITableView) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier(self.identifier)
        
        if (cell == nil) {
            cell = ZYRightCenterCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: self.identifier)
        }
        return cell!
    }
    
    /**
     这里需要注意的是，在OC中，当我们从一个xib里面加载一个view的时候，是可以直接赋值给self的，
     也就是说，在oc中，这么写是对的：
     self = [NSBundle mainBundle].loadNibNamed(...).lastObject
     但是在swift中，这么写是错误的，self是不可被修改的
     所以，如果加载xib里面的view，我建议将之加载到contentView里面，也就是说，我们在自定义view的时候，主要加上这么一个用于承载xib里面的控件的view（stackoverflow上好多人是这么干的，暂时没有找到更好的解决方案）
     最后，需要注意，别忘了设置contentView的autolayout
     
     由于cell中本身就有contentView，所以这里是直接加载在它上面
     */
    private func commitInit() {
        self.backgroundColor = UIColor.clearColor()
        self.textLabel?.backgroundColor = UIColor.clearColor()
        let xibView = NSBundle.mainBundle().loadNibNamed("ZYRightCenterCell", owner: nil, options: nil).last as! UIView
        xibView.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(xibView)
        self.textLabel?.textColor = UIColor.whiteColor()
        self.textLabel?.font = UIFont.systemFontOfSize(13)
        xibView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    }
}
