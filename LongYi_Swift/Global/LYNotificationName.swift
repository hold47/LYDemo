//
//  NotificationName.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/11.
//

import Foundation

struct LYNotificationName {
    static let selectOrderController = NSNotification.Name(rawValue: "selectOrderController")
    
    
    static let paySuccess = NSNotification.Name(rawValue: "paySuccess")
    static let wechatAuthSuccess = NSNotification.Name(rawValue: "wechatAuthSuccess")
}
