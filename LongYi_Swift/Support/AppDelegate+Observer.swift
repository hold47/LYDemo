//
//  AppDelegate+Observer.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/2.
//

import Foundation

extension AppDelegate {
    /// 监听session,没有就弹出登录
    func addLoginSessionObserver () {
        UserPreference.shared.sessionRelay.subscribe(onNext: { (session) in
            /// 如果清空了session,则弹出登录页面
            let currentVC = Constant.keyWindow.currentController
            if session == nil && !(currentVC is LYLoginController) {
                let navi = BaseNavigationController(rootViewController: LYLoginController())
                navi.modalPresentationStyle = .fullScreen
                currentVC?.present(navi, animated: true)
            }
        }).disposed(by: disposeBag)
    }
}
