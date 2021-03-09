//
//  LYRegisterSuccessViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/10/30.
//

import UIKit

class LYRegisterSuccessViewModel: BaseViewModel {
    
    var account: LYAccountModel?

}

extension LYRegisterSuccessViewModel {
    
    func bindWechat(unionid: String, _ completion: ((LYError) -> Void)?) {
        API.user.rx.request(User.bindWechat(unionid: unionid)).subscribe { result in
            switch result {
            case .success:
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
}
