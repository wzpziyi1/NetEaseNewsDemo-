//
//  ZYImageExtension.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

extension UIImage {

    /**
     拉升图片，而不改变图片的形状
     
     - parameter imageName: 图片名
     
     - returns: UIImage
     */
    class func resizedImage(imageName: String) ->UIImage {
        let image = UIImage(named: imageName)
        return (image?.stretchableImageWithLeftCapWidth(Int((image?.size.width)! * 0.5), topCapHeight: Int((image?.size.height)! * 0.5)))!
    }
    
    /**
     根据color生成一张对应的图片
     
     - parameter color: 图片颜色
     
     - returns: UIImage
     */
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
    
    /**
     对图片增加文字
     
     - parameter img:   图片
     - parameter mark:  需要增加的文字
     - parameter rect:  将文字增加到的范围
     - parameter font:  文字字体
     - parameter color: 文字颜色
     
     - returns: UIImage
     */
    class func addText(img:UIImage, mark:NSString, rect:CGRect, font:UIFont, color:UIColor) -> UIImage{
        let h = rect.size.height;
        let w = rect.size.width;
        UIGraphicsBeginImageContext(img.size);
        color.set();
        img.drawInRect(CGRect(x: 0, y: 0, width: w, height: h));
        var attributeDict = Dictionary<String, AnyObject>()
        attributeDict[NSFontAttributeName] = font
        mark.drawInRect(rect, withAttributes: attributeDict);
        let newImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImg;
    }
    
    /**
     对图片进行压缩
     
     - parameter img:        需要压缩的图片
     - parameter targetSize: 压缩的尺寸
     
     - returns: UIImage
     */
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
    
    /**
     生成一张带边框的圆形图片
     
     - parameter imageName:   图片名
     - parameter borderWidth: 边框宽度
     - parameter borderColor: 边框颜色
     
     - returns: UIImage
     */
    class func circleImageWithName(imageName: String, borderWidth: CGFloat, borderColor: UIColor) ->UIImage
    {
        let oldImage = UIImage(named: imageName)
        
        let imageW = (oldImage?.size.width)! + 2 * borderWidth;
        let imageH = (oldImage?.size.height)! + 2 * borderWidth;
        let ImageSize = CGSizeMake(imageW, imageH)
        
        UIGraphicsBeginImageContextWithOptions(ImageSize, false, 0)
        
        let ref = UIGraphicsGetCurrentContext()
        
        //画边框（也就是最大的圆）
        borderColor.set()
        let bigRadius = imageW * 0.5; // 大圆半径
        let centerX = bigRadius; // 圆心
        let centerY = bigRadius;
        CGContextAddArc(ref, centerX, centerY, bigRadius, 0, CGFloat(M_PI * 2.0), 0);
        CGContextFillPath(ref); // 画圆
        
        // 画小圆
        let smallRadius = bigRadius - borderWidth;
        CGContextAddArc(ref, centerX, centerY, smallRadius, 0, CGFloat(M_PI * 2.0), 0);
        // 裁剪(后面画的东西才会受裁剪的影响)
        CGContextClip(ref);
        
        // 画图
        oldImage?.drawInRect(CGRectMake(borderWidth, borderWidth, oldImage!.size.width, oldImage!.size.height));
        
        // 7.取图
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 8.结束上下文
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
}
