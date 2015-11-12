//
//  ViewController.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//
//
/* 
    swift中默认都是强引用，但是可以使用weak修饰变量，来产生弱引用
    建议所有UI控件使用private修饰，始终不暴露它
    有选择的使用weak修饰UI控件
*/
import UIKit

class ZYMainViewController: UIViewController, ZYLeftMenuViewDelegate {

//MARK:- 常量
    
    let leftMenuH: CGFloat = 300
    let leftMenuW: CGFloat = 150
    let duration: NSTimeInterval = 0.5
    let margin: CGFloat = 100
    let rightMenuW: CGFloat = kScreenWidth - 50
    
//MARK:- UI控件
    
    private weak var leftMenuView: ZYLeftMenuView!
    private weak var newsVc: ZYNewsViewController!
    private weak var showingVc: UIViewController?
    
    private var coverBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupImage()
        
        self.setupVc()
        
        self.setupLeftMenuView()
        
        self.setupRightVc()
        
        self.setupCoverBtn()
    }
 
    
//MARK:- setup系列
    
    private func setupImage() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sidebar_bg")
        self.view.addSubview(imageView)
        imageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
    }
    
    private func setupLeftMenuView() {
        let leftMenuView = ZYLeftMenuView()
        leftMenuView.delegate = self
        self.view.addSubview(leftMenuView)
        self.leftMenuView = leftMenuView
        self.leftMenuView.hidden = true
        self.view.insertSubview(self.leftMenuView, atIndex: 1)
        leftMenuView.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 64)
        leftMenuView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0)
        leftMenuView.autoSetDimensionsToSize(CGSizeMake(leftMenuW, leftMenuH))
    }
    
    private func setupVc() {
        let newsVc = ZYNewsViewController()
        self.newsVc = newsVc
        createNavigationVc(newsVc, title: "新闻")
        
        let readingVc = UIViewController()
        readingVc.view.backgroundColor = kRandomColor()
        createNavigationVc(readingVc, title: "订阅")
        
        let photoVc = UIViewController()
        photoVc.view.backgroundColor = kRandomColor()
        createNavigationVc(photoVc, title: "图片")
        
        let videoVc = UIViewController()
        videoVc.view.backgroundColor = kRandomColor()
        createNavigationVc(videoVc, title: "视频")
        
        let commentVc = UIViewController()
        commentVc.view.backgroundColor = kRandomColor()
        createNavigationVc(commentVc, title: "跟帖")
        
        let radioVc = UIViewController()
        radioVc.view.backgroundColor = kRandomColor()
        createNavigationVc(radioVc, title: "电台")
        
    }
    
    private func setupCoverBtn() {
        self.coverBtn = UIButton(frame: UIScreen.mainScreen().bounds)
        self.coverBtn.backgroundColor = UIColor.clearColor()
        self.coverBtn.adjustsImageWhenHighlighted = false
        self.coverBtn.addTarget(self, action: Selector("clickCoverBtn:"), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    private func setupRightVc() {
        let rightVc = ZYRightViewController()
        rightVc.view.frame = CGRectMake(50, 0, kScreenWidth - 50, kScreenHeight)
        self.addChildViewController(rightVc)
    }
    
    private func createNavigationVc(rootVc: UIViewController, title: String) ->UIViewController {
        
        let nvc = ZYMainNavigationController(rootViewController: rootVc)
        let titleView = ZYTitleView()
        titleView.frame = CGRectMake(0, 0, 100, 44)
        titleView.title = title
        rootVc.navigationItem.titleView = titleView
        rootVc.navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItemWithTarget(self, action: Selector("clickLeftBarButtonItem"), imageName: "top_navigation_menuicon")
        rootVc.navigationItem.rightBarButtonItem = UIBarButtonItem.barButtonItemWithTarget(self, action: Selector("clickRightBarButtonItem"), imageName: "top_navigation_infoicon")
        
        self.addChildViewController(nvc)
        return rootVc
    }
    
//    func createVc<T: UIView>(classType: T.Type) {
//        let vc = classType.init()
//        
//    }

//MARK:- 点击事件
    
    @objc private func clickLeftBarButtonItem() {
        self.showingVc?.view.userInteractionEnabled = false
        self.leftMenuView.hidden = false
        UIView.animateWithDuration(duration, animations: { () -> Void in
            let scale: CGFloat = (kScreenHeight - 2 * 64) / kScreenHeight
            let removeDistance: CGFloat = self.leftMenuView.frame.width - ((kScreenWidth - kScreenWidth * scale) / 2.0)
            let transform = CGAffineTransformMakeScale(scale, scale)
            self.showingVc!.view.transform = CGAffineTransformTranslate(transform, removeDistance, 0)
            self.showingVc?.view.addSubview(self.coverBtn!)
            self.showingVc?.view.userInteractionEnabled = true
            })
        
        
    }
    
    @objc private func clickRightBarButtonItem() {
        let rightVc = self.childViewControllers.last
        self.view.addSubview((rightVc?.view)!)
        self.view.insertSubview((rightVc?.view)!, atIndex: 1)
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            let scale: CGFloat = (kScreenHeight - 2 * 64) / kScreenHeight
            let removeDistance: CGFloat = -self.rightMenuW
            
            let transform = CGAffineTransformMakeScale(scale, scale)
            self.showingVc!.view.transform = CGAffineTransformTranslate(transform, removeDistance, 0)
            self.showingVc?.view.addSubview(self.coverBtn!)
            self.showingVc?.view.userInteractionEnabled = true
            }) { (finish: Bool) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName(kZYRightBarButtonDidClickNotification, object: nil)
        }
    }
    
    @objc private func clickCoverBtn(btn: UIButton) {
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.showingVc?.view.transform = CGAffineTransformIdentity
            }) { (finished: Bool) -> Void in
            btn.removeFromSuperview()
            self.leftMenuView.hidden = true
            let rightVc = self.childViewControllers.last
            rightVc?.view.removeFromSuperview()
        }
    }
    
    
//MARK:- ZYLeftMenuViewDelegate
    
    func leftMenuView(leftMenuView: ZYLeftMenuView, didClickButtonAtIndex index: Int) {
        let tmpVc: UIViewController! = self.childViewControllers[index]
        if ( tmpVc != self.showingVc) {
            self.view.addSubview(tmpVc.view)
            if (self.coverBtn != nil)
            {
                self.coverBtn.removeFromSuperview()
                tmpVc.view.addSubview(self.coverBtn)
            }
            if (self.showingVc != nil) {
                tmpVc.view.transform = (self.showingVc?.view.transform)!
                self.showingVc?.view.removeFromSuperview()
            }
            self.showingVc = tmpVc
        }
        
        if (self.coverBtn != nil) {
            self.clickCoverBtn(self.coverBtn)
        }
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

