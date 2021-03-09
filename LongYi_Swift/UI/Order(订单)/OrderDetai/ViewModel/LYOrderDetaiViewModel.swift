//
//  LYOrderDetaiViewModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/10.
//

import Foundation

class LYOrderDetaiViewModel: BaseViewModel {
    /// 订单id
    var orderID: Int = 0
    /// 详情
    let orderDetailRelay = BehaviorRelay<LYOrderModel>(value: LYOrderModel())
}

extension LYOrderDetaiViewModel {
    
    func getOrderDetail(_ completion: ((LYError) -> Void)?) {
        API.order.rx.request(Order.orderDetail(orderID)).mapObject(LYOrderModel.self).subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.orderDetailRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
}
