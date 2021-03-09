//
//  LYYxbpViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/25.
//

import UIKit

extension LYYxbpViewModel {
    
    func getAd(_ completion: ((LYError) -> Void)?) {
        API.home.rx.request(Home.youxAd).mapObject(LYYxbpAdModel.self).subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.yxbpAdRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func getYouxTejia(_ completion: ((LYError) -> Void)?) {
        API.home.rx.request(Home.youxTejia(page: page, is_page: 0, page_size: 6)).mapObjectList(LYGoodsModel.self).subscribe { [weak self] result in
            switch result {
            case .success((let data, _)):
                self?.tejiaRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func getMoreYoux(isRefresh: Bool, _ completion: ((LYError, Bool) -> Void)?) {
        if isRefresh { param.page = 1 }
        param.is_youx = 1
        API.goods.rx.request(Goods.list(param)).mapObjectList(LYGoodsModel.self).subscribe { [weak self] result in
            switch result {
            case .success((let data, let hasmore)):
                if isRefresh {
                    self?.moreRelay.accept(data)
                } else {
                    guard let temp = self?.moreRelay.value else { return }
                    let result = temp + data
                    self?.moreRelay.accept(result)
                }
                self?.param.page! += 1
                completion?(LYRequestError.success, hasmore)
            case .error(let error):
                completion?(error as! LYRequestError, false)
            }
        }.disposed(by: disposeBag)
    }
    
}

class LYYxbpViewModel: BaseViewModel {
    /// 获取商品列表的参数
    var param = LYGoodsSearchParameterModel()
    let yxbpAdRelay = BehaviorRelay<LYYxbpAdModel?>(value: nil)
    let tejiaRelay = BehaviorRelay<[LYGoodsModel]>(value: [])
    let moreRelay = BehaviorRelay<[LYGoodsModel]>(value: [])
}
