//
//  LYCartViewModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/8.
//

import UIKit

class LYCartViewModel: BaseViewModel {
//    /// 购物车列表
//    let cartOrderRelay = BehaviorRelay<[LYCartOrderModel]>(value: [])
//    /// 订单确定信息
//    let checkoutOrderRelay = BehaviorRelay<LYCartCheckModel>(value: LYCartCheckModel())
//    /// 已选择订单
//    var selectCartOrder: [LYCartOrderModel]? {
//        return cartOrderRelay.value.filter { $0.isSelect ?? false }
//    }
//    /// 合计
//    var totolPrice: String? {
//        let total = cartOrderRelay.value.filter { (goods) -> Bool in
//            return goods.isSelect ?? false
//        }.map { (goods) -> Float in
//            let price = goods.price?.float() ?? 0
//            let number = goods.number?.float ?? 0
//            return price * number
//        }.reduce(0, +).string
//        return "合计: ¥\(total)"
//    }
//    /// 结算
//    var countTitle: String? {
//        var count = ""
//        guard let selectgoods = selectCartOrder else { return nil }
//        if selectgoods.count > 0 {
//            count = "(\(selectgoods.count.string))"
//        } else {
//            count = ""
//        }
//        return "结算\(count)"
//    }
//    /// 全选
//    var isAllSelect: Bool {
//        return ((selectCartOrder?.count ?? 0) == cartOrderRelay.value.count) && (cartOrderRelay.value.count > 0)
//    }
    
}

extension LYCartViewModel {
    
    /// 获取购物车列表
    func getCartList(_ completion: ((LYError) -> Void)?) {
        API.cart.rx.request(Cart.list).subscribe { result in
            switch result {
            case .success(_):
                //  默认选择所有物品
//                data.forEach{ $0.isSelect = true }
//                self?.cartOrderRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    /// 编辑购物车,然后重新调用列表
    func editGoodsNumber(id: Int, number: Int, _ completion: ((LYError) -> Void)?) {
        API.cart.rx.request(Cart.editGoodsNumber(id: id, number: number)).subscribe { [weak self] result in
            switch result {
            case .success:
                self?.getCartList({ (error) in
                    if error == LYRequestError.success {
                        completion?(LYRequestError.success)
                    } else {
                        completion?(error as! LYRequestError)
                    }
                })
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    /// 删除物品,然后重新刷新列表
    func deleteGoods(ids: Int, _ completion: ((LYError) -> Void)?) {
        API.cart.rx.request(Cart.delete(ids: ids)).subscribe { [weak self] result in
            switch result {
            case .success:
                self?.getCartList({ (error) in
                    if error == LYRequestError.success {
                        completion?(LYRequestError.success)
                    } else {
                        completion?(error as! LYRequestError)
                    }
                })
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    /// 结算购物车
    func checkoutCart(ids: String, _ completion: ((LYError) -> Void)?) {
        API.cart.rx.request(Cart.checkout(ids: ids)).mapObject(LYCartCheckModel.self).subscribe { result in
            switch result {
            case .success:
//                self.checkoutOrderRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
}
