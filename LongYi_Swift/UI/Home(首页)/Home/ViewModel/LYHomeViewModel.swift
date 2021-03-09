//
//  LYHomeViewModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/9/30.
//

import UIKit

class LYHomeViewModel: BaseViewModel {
    /// 首页的大部分数据  banner,分类,龙一周选,middle,优选爆品
    let homeDataRelay = BehaviorRelay<LYHomeADModel>(value: LYHomeADModel())
    /// 秒杀数据
    let miaoshaDataRelay = BehaviorRelay<LYMiaoshaModel>(value: LYMiaoshaModel())
    /// 品牌专区数据
    let brandListDataRelay = BehaviorRelay<[LYBrandModel]>(value: [])
    /// 为你推荐数据
    let wntjListDataRelay = BehaviorRelay<[LYGoodsModel]>(value: [])
    /// 药聚会导航
    let yjhNaviRelay = BehaviorRelay<[LYYjhNaviModel]>(value: [])
    /// 药聚会药品
    let yjhGoodsRelay = BehaviorRelay<[LYGoodsModel]>(value: [])
    
    var yjhId = 0
    var yjhType = 0
}

extension LYHomeViewModel {
    
    func getAdData(_ completion: ((LYError) -> Void)?) {
        API.home.rx.request(Home.homeAD).mapObject(LYHomeADModel.self).subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.homeDataRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func getMiaoshaData(_ completion: ((LYError) -> Void)?) {
        API.home.rx.request(Home.miaosha).mapObject(LYMiaoshaModel.self).subscribe { result in
            switch result {
            case .success(let data):
                self.miaoshaDataRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func getBrandList(_ completion: ((LYError) -> Void)?) {
        API.home.rx.request(Home.brandList).mapObjectList(LYBrandModel.self).subscribe { result in
            switch result {
            case .success((let data, _)):
                self.brandListDataRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
    func getWntjList(isRefresh: Bool, _ completion: ((LYError, Bool) -> Void)?) {
        if isRefresh { page = 1 }
        API.goods.rx.request(Goods.tag(id: 1, page: page)).mapObjectList(LYGoodsModel.self).subscribe { [weak self] result in
            switch result {
            case .success((let data, let hasmore)):
                if isRefresh {
                    self?.wntjListDataRelay.accept(data)
                } else {
                    guard let temp = self?.wntjListDataRelay.value else { return }
                    let result = temp + data
                    self?.wntjListDataRelay.accept(result)
                }
                self?.page += 1
                completion?(LYRequestError.success, hasmore)
            case .error(let error):
                completion?(error as! LYRequestError, false)
            }
        }.disposed(by: disposeBag)
    }
    
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
    
    func getYjhGoods(_ completion: ((LYError) -> Void)?) {
        API.home.rx.request(Home.yjhList(id: yjhId, type: yjhType, number: 6, page: 1)).mapObjectList(LYGoodsModel.self).subscribe { [weak self] result in
            switch result {
            case .success((let data, _)):
                self?.yjhGoodsRelay.accept(data)
                completion?(LYRequestError.success)
            case .error(let error):
                completion?(error as! LYRequestError)
            }
        }.disposed(by: disposeBag)
    }
    
}
