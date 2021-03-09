//
//  Int+extension.swift
//  firefly20200330
//
//  Created by Hold on 2020/5/19.
//  Copyright © 2020 mumu. All rights reserved.
//

import Foundation

extension Int {
    /// 时间戳 -> 日期   默认是"yyyy.MM.dd HH:mm"格式
    func convertToDate(_ format: String? = nil) -> String {
        let timeInterval = TimeInterval(self)
//        let timeInterval = TimeInterval(self / 1000)
        let date = Date.init(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        if format == nil {
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        } else {
            dateFormatter.dateFormat = format
        }
        return dateFormatter.string(from: date)
    }
    
    /// 按照微博显示时间的逻辑转换成字符串
    func convertToWeiBoDate() -> String {
        guard self > 0 else { return "" }
        let createAt = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dt = DateFormatter()
        if isThisYear(createAt: createAt) {
            let calender = Calendar.current
            if calender.isDateInToday(createAt) {
                let timeIntever = createAt.timeIntervalSinceNow.abs
                
                if timeIntever < 60 {
                    //  1分钟之前
                    return "刚刚"
                } else if timeIntever < 3600 {
                    //  1小时之前
                    let result = Int(timeIntever / 60)
                    return "\(result)分钟前"
                } else {
                    //  其它
                    let result = Int(timeIntever / 3600)
                    return "\(result)小时前"
                }
                
            } else if calender.isDateInYesterday(createAt) {
                //  昨天
                dt.dateFormat = "昨天 HH:mm"
            } else {
                //  其它
                dt.dateFormat = "MM-dd HH:mm"
            }
        } else {
            //  不是今年
            dt.dateFormat = "yyyy-MM-dd HH:mm"
        }
        
        return dt.string(from: createAt)
    }
    
    private func isThisYear(createAt: Date) -> Bool {
        let dt = DateFormatter()
        dt.dateFormat = "yyyy"
        //  获取发微博时间的年份
        let creatAtYear = dt.string(from: createAt)
        //  获取当前时间的年份
        let currentDateYear = dt.string(from: Date())
        //  判断是否是同一年
        return creatAtYear == currentDateYear
    }
}
