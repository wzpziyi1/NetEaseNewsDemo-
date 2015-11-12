//
//  NSDateExtension.swift
//  网易新闻Demo
//
//  Created by 王志盼 on 15/11/12.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

extension NSDate {
    /**
     判断是否为今天
     
     - returns: Bool
     */
    func isToday() ->Bool {
        let calendar = NSCalendar.currentCalendar()
        
        let unit: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
        let nowComponent = calendar.components(unit, fromDate: NSDate())
        
        let selfComponent = calendar.components(unit, fromDate: NSDate())
        
        return (nowComponent.year == selfComponent.year && nowComponent.month == selfComponent.month && nowComponent.day == selfComponent.day)
    }
    /**
     是否为昨天
     
     - returns: Bool
     */
    func isYesterday() ->Bool {
        let calendar = NSCalendar.currentCalendar()
        let nowDate = NSDate().dateWithYMD()
        let selfDate = self.dateWithYMD()
        
        let component = calendar.components(NSCalendarUnit.Day, fromDate: selfDate, toDate: nowDate, options: NSCalendarOptions())
        
        return (component.year == 0 && component.month == 0 && component.day == 1)
    }
    
    /**
     是否为今年
     
     - returns: Bool
     */
    func isThisYear() ->Bool {
        let calendar = NSCalendar.currentCalendar()
        
        let unit: NSCalendarUnit = [NSCalendarUnit.Year]
        let nowComponent = calendar.components(unit, fromDate: NSDate())
        
        let selfComponent = calendar.components(unit, fromDate: NSDate())
        
        return (nowComponent.year == selfComponent.year)
    }
    
    /**
     与现在差的时间
     
     - returns: NSDateComponents
     */
    func deltaWithNow() ->NSDateComponents {
        let calendar = NSCalendar.currentCalendar()
        
        let unit: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]
        
        return calendar.components(unit, fromDate: self, toDate: NSDate(), options: NSCalendarOptions())
    }
    
    func dateWithYMD() ->NSDate {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dateStr = format.stringFromDate(self)
        return format.dateFromString(dateStr)!
    }
    
    
}

