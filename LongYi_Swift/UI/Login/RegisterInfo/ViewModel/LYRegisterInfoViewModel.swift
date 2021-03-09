//
//  LYRegisterInfoViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/30.
//

import UIKit

class LYRegisterInfoViewModel: BaseViewModel {
    var account = LYAccountModel()

    private enum LYRegisterError: LYError {
        case nameInvalid
        case passwordInvalid
        case confirmPasswordInvalid
        case passwordIsNotSame
        case companyInvalid
        case contactNameInvalid
        case contactPhoneInvalid
        case regionInvalid
        
        var errorDescription: String? {
            switch self {
            case .nameInvalid:
                return "请输入正确的用户名"
            case .passwordInvalid:
                return "请输入密码"
            case .confirmPasswordInvalid:
                return "请再次输入密码"
            case .passwordIsNotSame:
                return "两次密码输入不一致"
            case .companyInvalid:
                return "请输入单位名称"
            case .contactNameInvalid:
                return "请输入联系人"
            case .contactPhoneInvalid:
                return "请输入联系人电话"
            case .regionInvalid:
                return "请选择区域"
            }
        }
    }
    
    /// 检查两次密码是否一致
    private func checkTwoPassword() -> Bool {
        return account.password == account.password_confirmation
    }
}

extension LYRegisterInfoViewModel {
    
    func registerAccount(_ completion: ((LYError) -> Void)?) {
        guard !(account.username?.isEmpty ?? true) else {
            completion?(LYRegisterError.nameInvalid)
            return
        }
        guard !(account.password?.isEmpty ?? true) else {
            completion?(LYRegisterError.passwordInvalid)
            return
        }
        guard !(account.password_confirmation?.isEmpty ?? true) else {
            completion?(LYRegisterError.confirmPasswordInvalid)
            return
        }
        guard account.password == account.password_confirmation else {
            completion?(LYRegisterError.passwordIsNotSame)
            return
        }
        guard !(account.company?.isEmpty ?? true) else {
            completion?(LYRegisterError.companyInvalid)
            return
        }
        guard !(account.contact_name?.isEmpty ?? true) else {
            completion?(LYRegisterError.contactNameInvalid)
            return
        }
        guard !(account.contact_phone?.isEmpty ?? true) else {
            completion?(LYRegisterError.contactPhoneInvalid)
            return
        }
        guard !(account.district?.string.isEmpty ?? true) else {
            completion?(LYRegisterError.regionInvalid)
            return
        }
        
        API.user.rx.request(User.register(account: account)).subscribe { result in
            switch result {
            case .success:
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)

    }
    
}
