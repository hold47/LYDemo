//
//  LYLoginViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/9/27.
//

import UIKit

class LYLoginViewModel: BaseViewModel {
    
    var name: String?
    var password: String?
    var phone: String?
    var code: String?
    
    /// 登录错误信息
    private enum LoginError: LYError {
        case nameInvalid
        case passwordInvalid
        case phoneInvalid
        case codeInvalid
        
        var errorDescription: String? {
            switch self {
            case .nameInvalid:
                return "请输入用户名"
            case .passwordInvalid:
                return "请输入密码"
            case .phoneInvalid:
                return "请输入电话号码"
            case .codeInvalid:
                return "请输入验证码"
            }
        }
    }
        
}

//  MARK: - Request
extension LYLoginViewModel {
    
    func sendCode(_ completion: ((LYError) -> Void)?) {
        guard !phone.isEmpty else {
            completion?(LoginError.phoneInvalid)
            return
        }
        
        API.user.rx.request(User.loginCode(phone: phone!)).subscribe { result in
            switch result {
            case .success:
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func login(_ completion: ((LYError) -> Void)?) {
        guard !name.isEmpty else {
            completion?(LoginError.nameInvalid)
            return
        }
        guard !password.isEmpty else {
            completion?(LoginError.passwordInvalid)
            return
        }
        
        API.user.rx.request(User.login(name: name!, password: password!)).subscribe { result in
            switch result {
            case .success:
                /// 获取session
                var session: String? = nil
                if let cookies = HTTPCookieStorage.shared.cookies {
                    for cookie in cookies where cookie.name == "longyiyy_session" {
                        session = cookie.value
                    }
                }
                //  保存
                let sessionModel = LoginUserSession(session: session)
                UserPreference.shared.setSession(sessionModel)
                
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func phoneLogin(_ completion: ((LYError) -> Void)?) {
        guard !phone.isEmpty else {
            completion?(LoginError.phoneInvalid)
            return
        }
        guard !code.isEmpty else {
            completion?(LoginError.codeInvalid)
            return
        }
        
        API.user.rx.request(User.phoneLogin(phone: phone!, code: code!)).subscribe { result in
            switch result {
            case .success:
                /// 获取session
                var session: String? = nil
                if let cookies = HTTPCookieStorage.shared.cookies {
                    for cookie in cookies where cookie.name == "longyiyy_session" {
                        session = cookie.value
                    }
                }
                //  保存
                let sessionModel = LoginUserSession(session: session)
                UserPreference.shared.setSession(sessionModel)
                
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func wechatLogin(_ completion: ((LYError) -> Void)?) {
        let unionid = UserPreference.shared.authRelay.value?.unionid ?? "0"
        API.user.rx.request(User.wechatLogin(unionid: unionid)).subscribe { result in
            switch result {
            case .success:
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
        
}

//  MARK: - Bind
extension LYLoginViewModel: ReactiveCompatible {}
extension Reactive where Base: LYLoginViewModel {
    var name: Binder<String?> { return Binder(base, binding: { $0.name = $1 }) }
    var password: Binder<String?> { return Binder(base, binding: { $0.password = $1 }) }
    var phone: Binder<String?> { return Binder(base, binding: { $0.phone = $1 }) }
    var code: Binder<String?> { return Binder(base, binding: { $0.code = $1 }) }
}
