//
//  LYModalSortCategoryViewModel.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/11.
//

import UIKit

class LYModalSortCategoryViewModel: BaseViewModel {
    
    let cateRelay = BehaviorRelay<[LYGoodsCategoryModel]>(value: [])
    var selectID: Int?

}

extension LYModalSortCategoryViewModel {
    
    func getCategory(_ completion: ((LYError) -> Void)?) {
        
//        API.goods.rx.request(Goods.goodsCategory).mapObjectList(LYGoodsCategoryModel.self).subscribe { [weak self] result in
//            switch result {
//            case .success((let data, _)):
//                self?.cateRelay.accept(data)
//                completion?(LYRequestError.success)
//            case .error(let error):
//                completion?(error as! LYRequestError)
//            }
//            
//        }.disposed(by: disposeBag)
        
    }
    
}
