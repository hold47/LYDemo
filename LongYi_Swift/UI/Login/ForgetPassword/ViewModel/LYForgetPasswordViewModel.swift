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
    
    /// ??????????????????????????????
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
                return "??????????????????"
            case .phoneInvalid:
                return "??????????????????????????????"
            case .codeInvalid:
                return "??????????????????"
            case .passwordInvalid:
                return "???????????????"
            case .confirmwordInvalid:
                return "?????????????????????"
            case .passwordIsNotSame:
                return "???????????????????????????"
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
