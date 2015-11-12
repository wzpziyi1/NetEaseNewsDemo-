//
//  ZYImageExtension.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

extension UIImage {

    //拉升图片，而不改变图片的形状
    class func resizedImage(imageName: String) ->UIImage {
        let image = UIImage(named: imageName)
        return (image?.stretchableImageWithLeftCapWidth(Int((image?.size.width)! * 0.5), topCapHeight: Int((image?.size.height)! * 0.5)))!
    }
    
    //根据color生成一张对应的图片
    class func imageWithColor(color: UIColor) ->UIImage {
        let imageW: CGFloat = 100
        let imageH: CGFloat = 100
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), false, 0)
        color.set()
        UIRectFill(CGRectMake(0, 0, imageW, imageH))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    //对图片增加文字
    class func addText(img:UIImage, mark:NSString, rect:CGRect, font:UIFont, color:UIColor) -> UIImage{
        let h = rect.size.height;
        let w = rect.size.width;
        UIGraphicsBeginImageContext(img.size);
        color.set();
        img.drawInRect(CGRect(x: 0, y: 0, width: w, height: h));
        mark.drawInRect(rect, withAttributes: nil);
        let newImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImg;
    }
    
    //对图片进行压缩
    class func imageCompress(img:UIImage, targetSize:CGSize) -> UIImage{
        let imageSize = img.size;
        let width = imageSize.width;
        let height = imageSize.height;
        let targetWidth = targetSize.width;
        let targetHeight = targetSize.height;
        var scaleFactor = CGFloat(0.0);
        var scaledWidth = targetWidth;
        var scaledHeight = targetHeight;
        var thumbnailPoint = CGPointMake(0.0,0.0);
        if !(CGSizeEqualToSize(imageSize, targetSize)){
            let widthFactor = targetWidth / width;
            let heightFactor = targetHeight / height;
            if (widthFactor > heightFactor){
                scaleFactor = widthFactor; // scale to fit height
            }else{
                scaleFactor = heightFactor; // scale to fit width
            }
            scaledWidth = width * scaleFactor;
            scaledHeight = height * scaleFactor;
            // center the image
            if (widthFactor > heightFactor){
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            }else if (widthFactor < heightFactor){
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
        UIGraphicsBeginImageContext(targetSize); // this will crop
        var thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        img.drawInRect(thumbnailRect);
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
        
    }
    
}
