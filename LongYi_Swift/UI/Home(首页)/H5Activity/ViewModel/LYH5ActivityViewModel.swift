//
//  LYH5ActivityViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/18.
//

import UIKit

class LYH5ActivityViewModel: BaseViewModel {
    
    let prepayRelay = BehaviorRelay<LYPayModel>(value: LYPayModel())
    /// 支付方式  1支付宝  2微信
    var payType = 1
    
}

extension LYH5ActivityViewModel {
    
    func postActivityId(_ activityId: String, completion: ((LYError) -> Void)?) {
        
        API.quan.rx.request(Quan.pay(activity_id: activityId, pay_type: payType)).mapObject(LYPayModel.self).subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.prepayRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func postOrderId(_ orderId: String, completion: ((LYError) -> Void)?) {
        
        API.quan.rx.request(Quan.payRetry(order_id: orderId, pay_type: payType)).mapObject(LYPayModel.self).subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.prepayRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
        
    }
    
}
