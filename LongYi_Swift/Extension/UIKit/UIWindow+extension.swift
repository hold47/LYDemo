//
//  UIWindow+extension.swift
//  firefly20200330
//
//  Created by Hold on 2020/5/28.
//  Copyright © 2020 mumu. All rights reserved.
//

import UIKit

extension UIWindow {
    
    /// 获取当前显示界面控制器
    var currentController: UIViewController? {
        return currentController()
    }

    private func currentController(controller: UIViewController? = Constant.keyWindow.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return currentController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return currentController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return currentController(controller: presented)
        }
        
        return controller
    }
}

