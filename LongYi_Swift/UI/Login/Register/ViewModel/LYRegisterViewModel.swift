//
//  LYRegisterViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/27.
//

import UIKit

class LYRegisterViewModel: BaseViewModel {
    var phone: String?
    var code: String?
    
    private enum RegisterError: LYError {
        case phoneInvalid
        
        var errorDescription: String? {
            switch self {
            case .phoneInvalid:
                return "请输入正确的手机号码"
            }
        }
    }
}

extension LYRegisterViewModel {
    
    func sendCode(_ completion: ((LYError) -> Void)?) {
        guard !phone.isEmpty else {
            completion?(RegisterError.phoneInvalid)
            return
        }
        
        API.user.rx.request(User.registerCode(phone: phone!)).subscribe { result in
            switch result {
            case .success:
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func validateCode(_ completion: ((LYError) -> Void)?) {
        API.user.rx.request(User.validRegisterCode(phone: phone!, code: code!)).subscribe { result in
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
extension LYRegisterViewModel: ReactiveCompatible {}
extension Reactive where Base: LYRegisterViewModel {
    var phone: Binder<String?> { return Binder(base, binding: { $0.phone = $1 }) }
    var code: Binder<String?> { return Binder(base, binding: { $0.code = $1 }) }
}
