//
//  ZYRightCenterView.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/11.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ZYRightCenterView: UIView, UITableViewDelegate, UITableViewDataSource {

    private var tableView = UITableView()
    
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
        self.addSubview(tableView)
        tableView.backgroundColor = UIColor.clearColor()    
        tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
    }
    
//MARK:- UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ZYRightCenterCell.creatRightCenterCellWithTableView(tableView) as! ZYRightCenterCell
        cell.imageView?.image = UIImage(named: "promoboard_icon_apps")
        cell.textLabel?.text = "商城，能赚能花，土豪当家"
        return cell
    }
}
