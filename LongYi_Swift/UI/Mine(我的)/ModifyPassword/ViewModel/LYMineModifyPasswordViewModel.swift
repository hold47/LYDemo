//
//  LYMineModifyPasswordViewModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/9/28.
//

import UIKit

class LYMineModifyPasswordViewModel: BaseViewModel {
    var oldPassword: String?
    var password: String?
    var confirmPassword: String?
    
    /// 错误信息
    private enum ModifyPasswordError: LYError {
        case oldPasswordInvalid
        case passwordInvalid
        case confirmPasswordInvalid
        case passwordInconsistent
        case passwordShort
        
        var errorDescription: String? {
            switch self {
            case .oldPasswordInvalid:
                return "原密码错误"
            case .passwordInvalid:
                return "请输入密码"
            case .confirmPasswordInvalid:
                return "请输入确认密码"
            case .passwordInconsistent:
                return "两次输入密码不一致,请重新输入"
            case .passwordShort:
                return "密码需要超过6位"
            }
        }
    }
    
    private func checkPassword() -> Bool {
        return password == confirmPassword
    }
}

//  MARK: - Request
extension LYMineModifyPasswordViewModel {
    func modifyPassword(_ completion: ((LYError) -> Void)?) {
        guard !oldPassword.isEmpty else {
            completion?(ModifyPasswordError.oldPasswordInvalid)
            return }
        guard !password.isEmpty else {
            completion?(ModifyPasswordError.passwordInvalid)
            return }
        guard password!.count > 5 else {
            completion?(ModifyPasswordError.passwordShort)
            return }
        guard !confirmPassword.isEmpty else {
            completion?(ModifyPasswordError.confirmPasswordInvalid)
            return }
        guard checkPassword() else {
            completion?(ModifyPasswordError.passwordInconsistent)
            return
        }
     
//        API.user.rx.request(User.modifyPassword(old_password: oldPassword!, new_password: password!, confirm_password: confirmPassword!)).subscribe { result in
//            switch result {
//            case .success:
//                completion?(LYRequestError.success)
//            case .error(let error):
//                completion?(error as! LYRequestError)
//            }
//        }.disposed(by: disposeBag)
        
    }
}

//  MARK: - 绑定输入框信息
extension LYMineModifyPasswordViewModel: ReactiveCompatible {}
extension Reactive where Base: LYMineModifyPasswordViewModel {
    var oldPassword: Binder<String?> { return Binder(base, binding: { $0.oldPassword = $1 })}
    var password: Binder<String?> { return Binder(base, binding: { $0.password = $1 })}
    var confirmPassword: Binder<String?> { return Binder(base, binding: { $0.confirmPassword = $1 })}
}

