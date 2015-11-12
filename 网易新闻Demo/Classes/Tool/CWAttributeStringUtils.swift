//
//  CWAttributeStringUtils.swift
//  HealthRoom
//
//  Created by yanglei on 15/7/14.
//  Copyright (c) 2015年 criwell. All rights reserved.
//

import Foundation

//class CWAttributeStringUtils {
//    
//    class func attributeStringWithArray(array : Array<CWRegexResult>, matchColor:UIColor, unmatchColor:UIColor) -> NSAttributedString{
//        
//        var attributeString = NSMutableAttributedString();
//        let nsarray:NSArray = array;
//        nsarray.enumerateObjectsUsingBlock { (result:AnyObject!, idx:Int, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
//            let regexResult = result as! CWRegexResult;
//            var tmpString = NSMutableAttributedString(string: regexResult.string);
//            if (regexResult.matching != nil) {
//                tmpString.addAttribute(NSForegroundColorAttributeName, value:matchColor, range: NSMakeRange(0, regexResult.string.length()));
//                
//            }else{
//                tmpString.addAttribute(NSForegroundColorAttributeName, value:unmatchColor, range: NSMakeRange(0, regexResult.string.length()));
//            }
//            attributeString.appendAttributedString(tmpString);
//        }
//        attributeString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(17.0), range: NSMakeRange(0, attributeString.length));
//        
//        return attributeString;
//    }
//}