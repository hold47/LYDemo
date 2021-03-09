//
//  LYGoodsViewModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/5.
//

import UIKit

class LYGoodsViewModel: BaseViewModel {
    var goodsID: Int = 0
    var goodsInfoRelay = BehaviorRelay<LYGoodsModel>(value: LYGoodsModel())
    var tuijianRelay = BehaviorRelay<[LYGoodsModel]>(value: [])
}

extension LYGoodsViewModel {
    
    func getGoodsDetail(_ completion: ((LYError) -> Void)?) {
        API.goods.rx.request(Goods.detail(goodsID)).mapObject(LYGoodsModel.self).subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.goodsInfoRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func getWntj(_ completion: ((LYError) -> Void)?) {
        API.goods.rx.request(Goods.tag(id: 1, page: 1)).mapObjectList(LYGoodsModel.self).subscribe { [weak self] result in
            switch result {
            case .success((let data, _)):
                self?.tuijianRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func addLike(goods_ids: [String] , completion: ((LYError) -> Void)?) {
        let ids = String.arrayToString(array: goods_ids, seperator: ",")
        API.goods.rx.request(Goods.favorite(ids)).subscribe { result in
            switch result {
            case .success(_):
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func cancelLike(goods_ids: [String] , completion: ((LYError) -> Void)?) {
        let ids = String.arrayToString(array: goods_ids, seperator: ",")
        API.goods.rx.request(Goods.cancelFavorite(ids)).subscribe { result in
            switch result {
            case .success(_):
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func addCart(goods_id: Int, number: Int, price: String, _ completion: ((LYError) -> Void)?) {
//        API.cart.rx.request(Cart.add(goods_id: goods_id, number: number, price: price)).subscribe { result in
//            switch result {
//            case .success:
//                completion?(LYRequestError.success)
//            case .error(let error):
//                completion?(error as! LYRequestError)
//            }
//        }.disposed(by: disposeBag)
    }
    
}
