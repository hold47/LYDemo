//
//  Common+Functions.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/24.
//

import Foundation

/// 自定义打印
func LYPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
//    #if DEBUG
    for item in items {
        print(item, separator: separator, terminator: terminator)
    }
//    #endif
}

/// 从SB中加载控制器
public func loadController(_ storyBoard: String, identifier: String) -> UIViewController {
    let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: identifier)
}
