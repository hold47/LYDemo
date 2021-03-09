//
//  LYOrderViewModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/6.
//

import UIKit

class LYOrderViewModel: BaseViewModel {
    var startTime: String?
    var endTime: String?
    /// 请求参数
    var param = LYOrderSearchParameterModel()
    /// 订单列表
    let orderRelay = BehaviorRelay<[LYOrderModel]>(value: [])
}

extension LYOrderViewModel {
    
    func getOrderList(isRefresh: Bool, _ completion: ((LYError, Bool) -> Void)? ) {
        
        if isRefresh { param.page = 1 }
        param.start_time = startTime
        param.end_time = endTime
        
        API.order.rx.request(Order.orderList(param)).mapObjectList(LYOrderModel.self).subscribe { [weak self] result in
            switch result {
            case .success((let data, let hasmore)):
                if isRefresh {
                    self?.orderRelay.accept(data)
                } else {
                    guard let temp = self?.orderRelay.value else { return }
                    let result = temp + data
                    self?.orderRelay.accept(result)
                }
                self?.param.page! += 1
                completion?(LYRequestError.success, hasmore)
            case .error(let error):
                completion?(error as! LYRequestError, false)
            }
        }.disposed(by: disposeBag)
    }
    
}

//  MARK: - Binder
extension LYOrderViewModel: ReactiveCompatible {}
extension Reactive where Base: LYOrderViewModel {
    var startTime: Binder<String?> { return Binder(base, binding: { $0.startTime = $1 }) }
    var endTime: Binder<String?> { return Binder(base, binding: { $0.endTime = $1 }) }
}

