//
//  LYForgetPasswordViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/3.
//

import UIKit

extension LYForgetPasswordViewModel {
    
    func sendCode(_ completion: ((LYError) -> Void)?) {
        guard !phone.isEmpty else {
            completion?(ForgetError.phoneInvalid)
            return
        }
        
        API.user.rx.request(User.forgetCode(phone: phone!)).subscribe { result in
            switch result {
            case .success:
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func validCode(_ completion: ((LYError) -> Void)?) {
        guard !name.isEmpty else {
            completion?(ForgetError.nameInvalid)
            return
        }
        guard !phone.isEmpty else {
            completion?(ForgetError.phoneInvalid)
            return
        }
        guard !code.isEmpty else {
            completion?(ForgetError.codeInvalid)
            return
        }
        
        API.user.rx.request(User.validForgetCode(phone: phone!, username: name!, code: code!)).subscribe { result in
            switch result {
            case .success:
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func resetPassword(_ completion: ((LYError) -> Void)?) {
        guard !password.isEmpty else {
            completion?(ForgetError.passwordInvalid)
            return
        }
        guard !confirmword.isEmpty else {
            completion?(ForgetError.confirmwordInvalid)
            return
        }
        guard checkTwoPassword() else {
            completion?(ForgetError.passwordIsNotSame)
            return
        }
        
        API.user.rx.request(User.resetPassword(username: name!, password: password!, password_confirmation: confirmword!)).subscribe { result in
            switch result {
            case .success:
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    /// 检查两次密码是否一致
    private func checkTwoPassword() -> Bool {
        return password == confirmword
    }
    
}

class LYForgetPasswordViewModel: BaseViewModel {
    var name: String?
    var phone: String?
    var code: String?
    var password: String?
    var confirmword: String?
    
    private enum ForgetError: LYError {
        case nameInvalid
        case phoneInvalid
        case codeInvalid
        case passwordInvalid
        case confirmwordInvalid
        case passwordIsNotSame
        
        var errorDescription: String? {
            switch self {
            case .nameInvalid:
                return "请输入用户名"
            case .phoneInvalid:
                return "请输入正确的手机号码"
            case .codeInvalid:
                return "请输入验证码"
            case .passwordInvalid:
                return "请输入密码"
            case .confirmwordInvalid:
                return "请再次输入密码"
            case .passwordIsNotSame:
                return "两次密码输入不一致"
            }
        }
    }

}

//  MARK: - Bind
extension LYForgetPasswordViewModel: ReactiveCompatible {}
extension Reactive where Base: LYForgetPasswordViewModel {
    var name: Binder<String?> { return Binder(base, binding: { $0.name = $1 }) }
    var phone: Binder<String?> { return Binder(base, binding: { $0.phone = $1 }) }
    var code: Binder<String?> { return Binder(base, binding: { $0.code = $1 }) }
    var password: Binder<String?> { return Binder(base, binding: { $0.password = $1 }) }
    var confirmword: Binder<String?> { return Binder(base, binding: { $0.confirmword = $1 }) }
}
