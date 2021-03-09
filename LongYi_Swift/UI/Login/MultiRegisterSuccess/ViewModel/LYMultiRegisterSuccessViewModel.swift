//
//  LYMultiRegisterSuccessViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/2.
//

import UIKit

class LYMultiRegisterSuccessViewModel: BaseViewModel {
    
    var accountList: [LYAccountShopModel]?
    var isShow = false
    
}

extension LYMultiRegisterSuccessViewModel {
    
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
