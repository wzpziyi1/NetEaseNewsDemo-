//
//  ZYRightViewController.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/10.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ZYRightViewController: UIViewController {

    //MARK:- constant
    let duration: NSTimeInterval = 0.5
    
    @IBOutlet weak private var iconImageView: UIImageView!
    
    init() {
        super.init(nibName: "ZYRightViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCenterView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setupIconAnimate", name: kZYRightBarButtonDidClickNotification, object: nil)
    }
    
//MARK:- setup Method
    @objc private func setupIconAnimate() {
        
        UIView.transitionWithView(self.iconImageView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: {() ->Void in
                self.iconImageView.image = UIImage(named: "default_avatar")
            }) { (finished: Bool) -> Void in
                UIView.transitionWithView(self.iconImageView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
                        self.iconImageView.image = UIImage(named: "user_defaultgift")
                    }, completion: { (finished: Bool) -> Void in
                        
                })
        }
    }
    
    private func setupCenterView() {
        let leftMargin: CGFloat = 30
        let topMargin: CGFloat = 80
        
        let centerView = ZYRightCenterView()
        self.view.addSubview(centerView)
        centerView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: leftMargin)
        centerView.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: leftMargin)
        centerView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: self.iconImageView, withOffset: topMargin)
        centerView.autoSetDimension(ALDimension.Height, toSize: 135)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
