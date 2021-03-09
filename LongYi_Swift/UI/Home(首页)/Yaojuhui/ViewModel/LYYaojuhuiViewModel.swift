//
//  LYYaojuhuiViewModel.swift
//  LongYi_Swift
//
//  Created by Hold on 2020/11/24.
//

import UIKit

extension LYYaojuhuiViewModel {
    
    func getYjhNavi(_ completion: ((LYError) -> Void)?) {
        API.home.rx.request(Home.yjhNavi).mapObjectList(LYYjhNaviModel.self).subscribe { [weak self] result in
            switch result {
            case .success((let data, _)):
                self?.yjhNaviRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func getYjhGoods(isRefresh: Bool, _ completion: ((LYError, Bool) -> Void)?) {
        if isRefresh { page = 1 }
        
        API.home.rx.request(Home.yjhList(id: yjhId, type: yjhType, number: 12, page: page)).mapObjectList(LYGoodsModel.self).subscribe { [weak self] result in
            switch result {
            case .success((let data, let hasmore)):
                if isRefresh {
                    self?.yjhGoodsRelay.accept(data)
                } else {
                    guard let temp = self?.yjhGoodsRelay.value else { return }
                    let result = temp + data
                    self?.yjhGoodsRelay.accept(result)
                }
                self?.page += 1
                completion?(LYRequestError.success, hasmore)
            case .error(let error):
                completion?(error as! LYRequestError, false)
            }
        }.disposed(by: disposeBag)
    }
    
}

class LYYaojuhuiViewModel: BaseViewModel {
    /// 药聚会导航
    let yjhNaviRelay = BehaviorRelay<[LYYjhNaviModel]>(value: [])
    /// 药聚会药品
    let yjhGoodsRelay = BehaviorRelay<[LYGoodsModel]>(value: [])
    var yjhId = 0
    var yjhType = 0
}
