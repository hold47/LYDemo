//
//  UserPreference.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/24.
//

import UIKit
import Alamofire

enum kNetworkState {
    case wifi
    case cellular   //  窝蜂网
    case notReachable
    case unknown
}

class UserPreference {
    
    static let shared = UserPreference()
    /// 网络状态
    let netWorkStateRelay = BehaviorRelay<kNetworkState>(value: .cellular)
    var netListener: NetworkReachabilityManager?
    
    let sessionRelay: BehaviorRelay<LoginUserSession?> = BehaviorRelay(value: Plist.default.value(for: DefaultsKeys.loginSession))
    /// 当前user信息
    let userRelay: BehaviorRelay<UserModel?> = BehaviorRelay(value: Plist.default.value(for: DefaultsKeys.userInfo))
    /// 当前微信auth
    let authRelay: BehaviorRelay<LYWeChatAuthModel?> = BehaviorRelay(value: Plist.default.value(for: DefaultsKeys.auth))
    
    
    let isUpdateUserInfoRelay: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    /// 广告更新
    let isUpdateADRelay = BehaviorRelay<Bool>(value: true)
    let adStringRelay = BehaviorRelay<String?>(value: nil)
}

extension UserPreference {
    /// 监听网络状态
    func startNetstateObserve() {
        netListener = NetworkReachabilityManager.default
        netListener?.startListening(onQueue: .global(), onUpdatePerforming: { [weak self] status in
            switch status {
            case .reachable(.ethernetOrWiFi):
                self?.netWorkStateRelay.accept(.wifi)
            case .reachable(.cellular):
                self?.netWorkStateRelay.accept(.cellular)
            case .notReachable:
                self?.netWorkStateRelay.accept(.notReachable)
            case .unknown:
                self?.netWorkStateRelay.accept(.unknown)
            }
        })
    }
    
    func setSession(_ session: LoginUserSession?) {
        synchronized(self) {
            Plist.default.set(session, for: DefaultsKeys.loginSession)
            self.sessionRelay.accept(session)
            Plist.default.synchronize()
        }
    }
    
    func setToken(_ token: LoginUserToken?) {
        synchronized(self) {
            Plist.default.set(token, for: DefaultsKeys.loginToken)
//            self.tokenRelay.accept(token)
            self.isUpdateADRelay.accept(token != nil)
            self.isUpdateUserInfoRelay.accept(token != nil)
            Plist.default.synchronize()
        }
    }
    
    func setAuth(_ auth: LYWeChatAuthModel?) {
        synchronized(self) {
            Plist.default.set(auth, for: DefaultsKeys.auth)
            self.authRelay.accept(auth)
            Plist.default.synchronize()
        }
    }
    
    func setUserInfo(_ userInfo: UserModel?) {
        synchronized(self) {
            self.userRelay.accept(userInfo)
            Plist.default.set(userInfo, for: DefaultsKeys.userInfo)
            Plist.default.synchronize()
        }
    }
    
    func logout() {
        setToken(nil)
        setUserInfo(nil)
        setSession(nil)
        setAuth(nil)
    }
}

