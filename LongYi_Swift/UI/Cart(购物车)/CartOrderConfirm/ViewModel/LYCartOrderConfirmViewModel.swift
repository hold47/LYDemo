//
//  LYCartOrderConfirmViewModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/13.
//

import Foundation

class LYCartOrderConfirmViewModel: BaseViewModel {
    /// 传过来的data
    var cartCheckData: LYCartCheckModel?
    var comment: String?
    var payType: Int?
    let commitOrderRelay = BehaviorRelay<LYCartOrderCommitModel>(value: LYCartOrderCommitModel())
    
    private enum LYCartOrderError: LYError {
        case payTypeInvalid
        
        var errorDescription: String? {
            switch self {
            case .payTypeInvalid:
                return "请选择支付方式"
            }
        }
    }
    
}

extension LYCartOrderConfirmViewModel {
    
    /// 提交订单
    func commitCart(ids: String, pay_id: Int?, remarks: String?, _ completion: ((LYError) -> Void)?) {
        guard pay_id != nil else {
            completion?(LYCartOrderError.payTypeInvalid)
            return
        }
        API.cart.rx.request(Cart.create(ids: ids, pay_id: pay_id!, remarks: remarks)).mapObject(LYCartOrderCommitModel.self).subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.commitOrderRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }

        }.disposed(by: disposeBag)
    }
    
}
