//
//  ZYRightCenterCell.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/11.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ZYRightCenterCell: UITableViewCell {

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
