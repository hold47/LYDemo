//
//  Date+extension.swift
//  firefly20200330
//
//  Created by Hold on 2020/5/28.
//  Copyright © 2020 mumu. All rights reserved.
//

import Foundation

extension Date {
    
    func chatDateString() -> String {
        let dt = DateFormatter()
        if isThisYear(createAt: self) {
            let calender = Calendar.current
            if calender.isDateInToday(self) {
                dt.dateFormat = "HH:mm"
            } else if calender.isDateInYesterday(self) {
                dt.dateFormat = "昨天 HH:mm"
            } else {
                dt.dateFormat = "MM月dd日 HH:mm"
            }
        } else {
            dt.dateFormat = "yyyy年MM月dd日 HH:mm"
        }
        return dt.string(from: self)
    }
    
    static func stringToTimeStamp(stringTime: String) -> String {
        let string = NSString(string: stringTime)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd"
        let dates = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: (dates as NSDate) as Date)
    }
    
    static func fullTimeFormat(stringTime: String) -> String {
        let string = NSString(string: stringTime)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dates = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: (dates as NSDate) as Date)
    }
    
    static func getCurrentTime(stringTime: String) -> String {
        let string = NSString(string: stringTime)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "HH:mm"
        let dates = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: (dates as NSDate) as Date)
    }
    
    static func getTimeOfTheMonth(stringTime: String) -> String {
        let string = NSString(string: stringTime)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyyMMdd"
        let dates = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: (dates as NSDate) as Date)
    }
    
    /// 获取当前时间戳字符串
    ///
    /// - Returns: 当前时间戳字符串
    static func obtionNowTimeStamp() -> String {
        let timeInterval = NSDate().timeIntervalSince1970 * 1000
        return NSString(format: "%d", timeInterval) as String
    }
    
    static func dateNoGap(stringTime: String) -> String {
        let string = NSString(string: stringTime)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "HH"
        let dates = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: (dates as NSDate) as Date)
    }
    
    static func dateToDay(stringTime: String) -> String {
        let string = NSString(string: stringTime)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "dd"
        let dates = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: (dates as NSDate) as Date)
    }
    
    var timeStamp: String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    var yyyyMMdd: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    var yyyyMMdd2: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
    
    var yyyyMM: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.string(from: self)
    }
    
    /// yyyy.MM
    var yyyyMM3: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter.string(from: self)
    }
    
    /// yyyyMM
    var yyyyMM2: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMM"
        return formatter.string(from: self)
    }
    
    var yyyyYMMM: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        return formatter.string(from: self)
    }

    var HHmmss: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: self)
    }

    var yyMMddHHmm: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd HH:mm"
        return formatter.string(from: self)
    }

    var MMdd: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: self)
    }

    var HHmm: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    var dd: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    var MMddHanzi: String {
        let month = self.month
        var monthStr = "\(month)"
        switch month {
        case 1: monthStr = "一月"
        case 2: monthStr = "二月"
        case 3: monthStr = "三月"
        case 4: monthStr = "四月"
        case 5: monthStr = "五月"
        case 6: monthStr = "六月"
        case 7: monthStr = "七月"
        case 8: monthStr = "八月"
        case 9: monthStr = "九月"
        case 10: monthStr = "十月"
        case 11: monthStr = "十一月"
        case 12: monthStr = "十二月"
        default: break
        }
        return "\(monthStr)\n\(self.day)"
    }
    
    private func isThisYear(createAt: Date) -> Bool {
            let dt = DateFormatter()
            dt.dateFormat = "yyyy"
            let creatAtYear = dt.string(from: createAt)
            let currentDateYear = dt.string(from: Date())
            return creatAtYear == currentDateYear
    }
    
}
