//
//  UIFont+extension.swift
//  firefly20200330
//
//  Created by Hold on 2020/5/22.
//  Copyright © 2020 mumu. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func pingFangWith(_ size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func pingFangMediumWith( size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func pingFangSemiboldWith( size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func pingFangLight( size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
