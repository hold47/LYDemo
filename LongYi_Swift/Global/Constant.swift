//
//  Constant.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/24.
//

import UIKit

struct Constant {
    
    static let WeChatAppID = "wx1c3027ec40e8f81c"
    static let WeChatAppSecret = "ffbeda18a42d40bff2fea760c0b5c637"
    static let WeChatLink = "https://test.longyiyy.longyi100.com/"
    
    #if DEBUG
//    static let BaseUrl = "http://test.appapi.longyiyy.com/api/"
    static let BaseUrl = "http://app.api.longyiyy.com/api/"
//    static let BaseUrl = "http://a.app.api.longyiyy.com/api/"
    #else
    static let BaseUrl = "http://app.api.longyiyy.com/api/"
    #endif
    
    static let screen_width: CGFloat = UIScreen.main.bounds.size.width
    static let screen_height: CGFloat = UIScreen.main.bounds.size.height
    static var statusBar_height: CGFloat {
        if #available(iOS 13, *) {
            return Constant.keyWindow.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    static let navigationBar_height: CGFloat = 44 + statusBar_height
    static let is_iphoneX: Bool = statusBar_height > 20
    static let tabBar_height: CGFloat = 49 + (is_iphoneX ? 34.0 : 0)
    
    static let mainColor = UIColor(hexString: "#0CB95F")!
    static let yjhColor = UIColor(hexString: "#4091FD")!
    static let tableViewBgColor = UIColor(hexString: "F5F5F5")!
    static let margin: CGFloat = 12

    static var keyWindow: UIWindow {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.filter{ $0.isKeyWindow }.first ?? UIWindow()
        } else {
            return UIApplication.shared.keyWindow ?? UIWindow()
        }
    }
    static var safeArea: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return keyWindow.safeAreaInsets
        } else {
            return UIEdgeInsets.zero
        }
    }
    static let docPath = "\(NSHomeDirectory())/Documents"
    /// 分页默认size
    static let pageSize = 20
    /// 默认占位图
    static let placeHolder = UIImage(named: "placeholder")
}
