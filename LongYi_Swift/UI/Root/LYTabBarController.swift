//
//  LYTabBarController.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/24.
//

import UIKit

class LYTabBarController: UITabBarController {
    
    static let shared: LYTabBarController = LYTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        delegate = self
        tabBar.tintColor = Constant.mainColor
        
        let titles = ["首页", "分类", "购物车", "我的"]
        let vcArray = [LYHomeController(), LYSortController(), LYCartController(), LYMineController()]
        var images = ["tabbar_home", "tabbar_sort", "tabbar_cart", "tabbar_mine"]
        var selectImages = ["tabbar_home_select", "tabbar_sort_select", "tabbar_cart_select", "tabbar_mine_select"]
        
        //  双十一首页
        let is1111 = UserDefaults.standard.bool(forKey: "is1111")
        if is1111 {
            images = ["tabbar_1111_home", "tabbar_1111_sort", "tabbar_1111_cart", "tabbar_1111_mine"]
            selectImages = ["tabbar_1111_home_select", "tabbar_1111_sort_select", "tabbar_1111_cart_select", "tabbar_1111_mine_select"]
            tabBar.tintColor = UIColor(hexString: "6710D2")
        }
        
        var tempArray = [BaseNavigationController]()
        for (i, title) in titles.enumerated() {
            let navi = BaseNavigationController(rootViewController: vcArray[i])
            /// 设置tabBarItem颜色
            navi.tabBarItem = UITabBarItem(title: title, image: UIImage(named: images[i])?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: selectImages[i])?.withRenderingMode(.alwaysOriginal))
            tempArray.append(navi)
        }
        viewControllers = tempArray
    }
    
}

extension LYTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //  购物车和我的需要登录后才能访问
        let isLogin = UserPreference.shared.sessionRelay.value
        if isLogin == nil && (item.title == "购物车" || item.title == "我的") {
            let navi = BaseNavigationController(rootViewController: LYLoginController())
            navi.modalPresentationStyle = .fullScreen
            Constant.keyWindow.currentController?.present(navi, animated: true, completion: nil)
        }
    }
    
}
