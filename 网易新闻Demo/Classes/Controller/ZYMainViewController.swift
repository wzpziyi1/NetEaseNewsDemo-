//
//  ViewController.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupImage()
    }
    
//MARK:- setup系列
    private func setupImage() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sidebar_bg")
        self.view.addSubview(imageView)
        imageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
    }
    
    
    
}

