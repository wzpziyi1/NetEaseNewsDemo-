//
//  CWRegexUtils.swift
//  HealthRoom
//
//  Created by yanglei on 15/7/14.
//  Copyright (c) 2015年 criwell. All rights reserved.
//

import Foundation
import UIKit
class CWRegexResult {
    var string:String!;
    var range:NSRange!;
    var matching:Bool!;
}

//class CWRegexUtils {
//    
//    class func arrayWithMatchedText(text : String, regexString:String)->Array<CWRegexResult>{
//        
//        var attributeArray = Array<CWRegexResult>();
//        let nstext = text as NSString;
//        //匹配需要染色的字符串
//        nstext.enumerateStringsMatchedByRegex(regexString, usingBlock: { (captureCount:Int, capturedStrings: UnsafePointer<NSString?>, capturedRanges : UnsafePointer<NSRange>, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
//            var result = CWRegexResult();
//            result.string =  capturedStrings.memory! as String;
//            result.range = capturedRanges.memory;
//            result.matching = true;
//            attributeArray.append(result);
//        })
//        //匹配不需要染色的字符串
//        nstext.enumerateStringsSeparatedByRegex(regexString, usingBlock: { (captureCount:Int, capturedStrings: UnsafePointer<NSString?>, capturedRanges : UnsafePointer<NSRange>, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
//            var result = CWRegexResult();
//            result.string =  capturedStrings.memory! as String;
//            result.range = capturedRanges.memory;
//            result.matching = false;
//            attributeArray.append(result);
//        })
//        attributeArray.sort { (obj1:CWRegexResult, obj2:CWRegexResult) -> Bool in
//            var loc1 = obj1.range.location;
//            var loc2 = obj2.range.location;
//            if (loc1 <= loc2) {
//                return true;
//            }
//            
//            return false;
//        }
//        
//        return attributeArray;
//    }
//    
//    class func attributeStringWithRegex(text:String, strRegex:String, matchColor:UIColor, attributeString:NSMutableAttributedString?) -> NSMutableAttributedString{
//        var tmpAttributeString = attributeString;
//        let nstext = text as NSString;
//        if(tmpAttributeString == nil){
//            tmpAttributeString = NSMutableAttributedString(string: text);
//        }
//        //匹配需要染色的字符串
//        nstext.enumerateStringsMatchedByRegex(strRegex, usingBlock: { (captureCount:Int, capturedStrings: UnsafePointer<NSString?>, capturedRanges : UnsafePointer<NSRange>, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
//            tmpAttributeString!.addAttribute(NSForegroundColorAttributeName, value:matchColor, range: (capturedRanges.memory as NSRange));
//        })
//        return tmpAttributeString!;
//    }
//}